//
//  YahooFinance.swift
//  Stock portfolio
//
//  Created by Yoni on 22/08/2020.
//  Copyright © 2020 Yoni. All rights reserved.
//

import Foundation

class YahooFinance : ApiProtocol{
    public static let shared = YahooFinance()
    
    private init(){}
    
    func serverRequest(with symbole:String){
        guard let url = URL(string: "https://apidojo-yahoo-finance-v1.p.rapidapi.com/stock/get-detail?region=US&lang=en&symbol=\(symbole)") else{return}
        let headers = [
            "x-rapidapi-host": "apidojo-yahoo-finance-v1.p.rapidapi.com",
            "x-rapidapi-key": "b301dd3f37msh8b50b358af26d9cp145cefjsn05937467f515"
        ]
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, res, err) in
            if err != nil{
                print(err?.localizedDescription ?? "Error")
            }else{
                guard let data = data else{return}
                do{
                    let jsonData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    print("------------------------")
                    print(self.jsonToString(with: jsonData))
                }catch{
                    print(error.localizedDescription)
                }
            }
            
        }.resume()
    }
    
    private func jsonToString(with json:Any) -> String{
        do{
            let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            let convertedString = (String(data: data, encoding: String.Encoding.utf8) ?? "" ) as String
            return convertedString
        }catch{
            print(error)
        }
        return ""
    }
    
    
//    func serverRequestWithStockStruct(with symbole:String ,complation:@escaping(StockDetaile) ->()){
//        guard let url = URL(string: "https://apidojo-yahoo-finance-v1.p.rapidapi.com/stock/get-detail?region=US&lang=en&symbol=\(symbole)") else{return}
//            let headers = [
//                "x-rapidapi-host": "apidojo-yahoo-finance-v1.p.rapidapi.com",
//                "x-rapidapi-key": "6f119be22bmsh0df81fc55126bb9p11ee86jsn6f5dc862c020"
//            ]
//            var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 15.0)
//            request.httpMethod = "GET"
//            request.allHTTPHeaderFields = headers
//
//            let session = URLSession.shared
//            session.dataTask(with: request) { (data, res, err) in
//                DispatchQueue.main.async {
//
//                    if let err = err{
//                        print(err.localizedDescription)
//                    }else{
//                        do{
//                            guard let data = data else{return}
//                            let decoder = JSONDecoder()
//                            let object = try decoder.decode(StockDetaile.self, from: data)
//                            complation(object)
//                        }catch{
//                            print(error)
//                        }
//                    }
//                }
//            }.resume()
//
//    }
    
    func serverRequestWithStockStruct(with symbole:String ,complation: @escaping(Result<StockDetaile>) -> ()){
        guard let url = URL(string: "https://apidojo-yahoo-finance-v1.p.rapidapi.com/stock/get-detail?region=US&lang=en&symbol=\(symbole)") else{return}
        let headers = [
            "x-rapidapi-host": "apidojo-yahoo-finance-v1.p.rapidapi.com",
            "x-rapidapi-key": "6f119be22bmsh0df81fc55126bb9p11ee86jsn6f5dc862c020"
        ]
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 15.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        fetch(with: request) { (result: Result<StockDetaile>) in
            complation(result)
        }
        
    }
}


