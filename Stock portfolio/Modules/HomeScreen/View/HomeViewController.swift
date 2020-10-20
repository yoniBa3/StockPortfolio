//
//  HomeViewController.swift
//  Stock portfolio
//
//  Created by Yoni on 15/08/2020.
//  Copyright © 2020 Yoni. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController{
    
    //MARK: -Outlets
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var profitStatuseImage: UIImageView!
    @IBOutlet weak var currencyTableView: UITableView!
    @IBOutlet weak var stocksTableView: UITableView!
    @IBOutlet weak var cellButton: CustomButton!
    @IBOutlet weak var buyButton: CustomButton!
    
    
    //MARK: -Properties
    var currencyActivityIndiactor = UIActivityIndicatorView()
    var presnter: HomeScreenPresenter!
    var noStocksInList = UILabel()
    
    //MARK: -Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configurePage()
    }
    
    
    //MARK: -Actions
    
    @IBAction func logOut(_ sender: UIBarButtonItem) {
        Utilities.shared.isUserConnectedStatus(false)
        Router.shared.goToLogIn()
    }
    
    @IBAction func cellTapped(_ sender: CustomButton) {
        sender.shakeButtomButton()
    }
    @IBAction func buyTapped(_ sender: CustomButton) {
        sender.shakeButtomButton()
        
    }
    
    //MARK: -Functions
    private func configurePage(){
        presnter = HomeScreenPresenter(delegate: self)
        configureParticals()
        currencyActivityIndiactor.setup(currencyTableView)
    }
    
    private func configureTable(){
        //CurrencyTableView
        currencyTableView.tableFooterView = UIView(frame: .zero)
        currencyTableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
       
        //StockTableView
        stocksTableView.tableFooterView = UIView(frame: .zero)
        stocksTableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        
    }
    
    private func configureParticals(){
        
        buyButton.setupeButton()
        cellButton.setupeButton()
        cellButton.isEnabled = false
        configureTable()
        
        
    }
    
    func showUserFullBalance(){
        balanceLabel.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(showBalance))
        balanceLabel.addGestureRecognizer(gesture)
    }
    
    @objc func showBalance(){
        presnter.showFullBalanceInAlert()
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == CellScreenViewController.identifier{
            if let CellScreenVC = segue.destination as? CellScreenViewController{
                CellScreenVC.stock = presnter.chosenStock
            }
        }
    }
    
}

extension HomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == currencyTableView{
            return presnter.getCurrenciesNumberOfRows()
        }
        if tableView == stocksTableView{
            return presnter.getUserStocksNumberOfRows()
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == currencyTableView{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.identifier) as? CurrencyTableViewCell else{return UITableViewCell()}
            if let currencyData = presnter.getCurrencyDataForTable(atIndex: indexPath.row){
                cell.configureCell(with: currencyData)
            }
            return cell
        }
        if tableView == stocksTableView{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UserStockTableViewCell.identifier) as? UserStockTableViewCell else{return UITableViewCell()}
            
            if let stockData = presnter.getHomeScreenStockVM(atIndex: indexPath.row){
                cell.configureCell(with: stockData)
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    
}

extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if currencyTableView == tableView{
            return tableView.bounds.height / 4
        }
        if stocksTableView == tableView{
            return tableView.bounds.height / 4
        }
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == currencyTableView{
            presnter.changeUserCurrency(atIndex: indexPath.row)
        }
        if tableView == stocksTableView{
            cellButton.isEnabled = true
            presnter.setUserStockSelection(atIndex: indexPath.row)
            
        }
    }
}


extension HomeViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let text = searchBar.text{
            presnter.filterCurrencyTable(withText: text)
        }
    }
}

extension HomeViewController: HomeScreenPresenterDelegate{
    func setNavigatorTitle(_ title: String) {
        self.title = title
    }
    
    func loadCurrencyTable() {
        currencyTableView.reloadData()
        self.currencyActivityIndiactor.stopAnimating()
    }
    
    func loadStockTable() {
        stocksTableView.reloadData()
    }
    
    func showUserMoneyAmount(_ moneyAmount: String, _ currencySymbole: String, _ statusAcount: AcountStatus) {
        var statusImage: UIImage!
        switch statusAcount {
        case .negative:
            statusImage = UIImage(named: "negativeRedTriangle")
        case .positive:
            statusImage = UIImage(named: "positiveTriangle")
        case .noChange:
            statusImage = UIImage(named: "positiveTriangle")?.withTintColor(.gray)
        }
        
        activityIndicator.stopAnimating()
        balanceLabel.text = "\(moneyAmount) \(currencySymbole)"
        profitStatuseImage.image = statusImage
        showUserFullBalance()

    }
    
    func showInformation(_ title: String, _ message: String) {
        showAlertController(title, message)
    }
    
    func refreshUserMoneyAmountInDifferentCurency(_ moneyAmount: String, _ currencySymbole: String) {
        balanceLabel.text = "\(moneyAmount) \(currencySymbole)"
    }
    
    func checkIfUserHasNoStocks(_ title:String){
        let point = stocksTableView.center
        noStocksInList.setup(with: view, and: title, point: point)
    }
    
}

