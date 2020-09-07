//
//  ApiProtocol.swift
//  Stock portfolio
//
//  Created by Yoni on 18/08/2020.
//  Copyright © 2020 Yoni. All rights reserved.
//

import Foundation

enum Result<T>{
    case success(value:T)
    case failure(description:String?)
}

protocol ApiProtocol {
    func fetch<T:Codable>(with url:URL ,complation:@escaping(Result<T>)->())
}


extension ApiProtocol{
    func fetch<T:Codable>(with url:URL ,complation:@escaping(Result<T>)->()){
        let session = URLSession.shared
        session.dataTask(with: url) { (data, res, err) in
            DispatchQueue.main.async {
                guard let data = data else{complation(.failure(description: "Data is nil"));return}
                do{
                    let decoder = JSONDecoder()
                    let object = try decoder.decode(T.self, from: data)
                    complation(.success(value: object))
                }catch{
                    print(error.localizedDescription)
                    complation(.failure(description: "Data is nil"))
                }
            }
        }.resume()
    }
}

