//
//  BuyStocksViewController.swift
//  Stock portfolio
//
//  Created by Yoni on 22/08/2020.
//  Copyright © 2020 Yoni. All rights reserved.
//

import UIKit

class StocksSelectionViewController: UIViewController {
    
    //MARK: -Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: -Properties
    public static let identifier = "GoToBuySegue"
    
    private var stockSelectionPresenter: StockSelectionPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        configurePage() 
      
    }
    
    //MARK: -Functions
    func configurePage(){
        stockSelectionPresenter = StockSelectionPresenter(stockSelectionPresenterDelegate: self)
        configureTable()
        configureBackButton()
        
    }
    
    func configureTable(){
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    private func configureBackButton(){
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goHome))
        self.navigationItem.leftBarButtonItem = newBackButton
    }
    
    @objc func goHome(){
        Router.shared.goToHomeVC()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == BuyScreenViewController.identifier{
            if let VC = segue.destination as? BuyScreenViewController{
                VC.stockVM = sender as? StockVM
            }
        }
    }

    
}

extension StocksSelectionViewController: StockSelectionPresenterDelegate{
    func reloadData() {
        tableView.reloadData()
    }
}

extension StocksSelectionViewController : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        stockSelectionPresenter.numberSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockSelectionPresenter.numberRowsInSection(withSection: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StockVMTableViewCell.identifier) as? StockVMTableViewCell else{return UITableViewCell()}
        
        if let stockVM = stockSelectionPresenter.getStockVM(withSection: indexPath.section, AtRow: indexPath.row){
            cell.configureCell(with: stockVM)
            
            if let isExpended = stockSelectionPresenter.checkIfIsExpended(withSection: indexPath.section){
                if isExpended{
                    cell.configureIfOpen(with: stockVM)
                }
            }
        }
        
        return cell
    }
}

extension StocksSelectionViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return stockSelectionPresenter.checkIfIsExpended(withSection: indexPath.section) == true ? 70 : 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpendableHeaderFooterView()
        header.setHeaderFooterView(title: stockSelectionPresenter.getSectionTitle(withSection: section) ?? "Title", section: section, delegate: self)
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let symbole = stockSelectionPresenter.getStockVM(withSection: indexPath.section, AtRow: indexPath.row){
            performSegue(withIdentifier: BuyScreenViewController.identifier, sender: symbole)
        }
        
    }
    
}

extension StocksSelectionViewController: ExpendableHeaderFooterViewDelegate{
    func toggleSection(header: ExpendableHeaderFooterView, section: Int) {
        if let stockArrayVM = stockSelectionPresenter.getArrayStockVM(withSection: section){
            stockSelectionPresenter.switchStatusIsExpended(withSection: section)
            tableView.beginUpdates()
            var indexPaths = [IndexPath]()
            for row in 0..<stockArrayVM.count {
                let indexPath = IndexPath(row: row, section: section)
                indexPaths.append(indexPath)
            }
            tableView.reloadRows(at: indexPaths, with: .fade)
            tableView.endUpdates()
        }
    }
}

extension StocksSelectionViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let text = searchBar.text{
            stockSelectionPresenter.filterStockList(with: text)
        }
    }
}
