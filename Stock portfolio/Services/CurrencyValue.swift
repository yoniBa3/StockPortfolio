//
//  CurrencyValue.swift
//  Stock portfolio
//
//  Created by Yoni on 18/08/2020.
//  Copyright © 2020 Yoni. All rights reserved.
//

import Foundation

class CurrencyValue:ApiProtocol{
    
    public static let shared = CurrencyValue()
    
    private init(){}
    
    func serverRequest(){
        
        guard let url = URL(string: "https://currency-value.p.rapidapi.com/global/currency_rates") else{return}
        
        let headers = [
            "x-rapidapi-host": "currency-value.p.rapidapi.com",
            "x-rapidapi-key": "905a5df034msh2dc9fd27a14af79p18bfd1jsn3c86123d4573"
        ]
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, _, err) in
            if err != nil{
                print(err?.localizedDescription ?? "Error from serverRequest" )
            }else{
                guard let data = data else{return}
                let string = String(data: data, encoding: .utf8)
                print(string ?? "")
            }
        }.resume()
    }
    
    func serverRequestWithCurrencyStruct(complition:@escaping(Currency) ->()){
        
        guard let url = URL(string: "https://currency-value.p.rapidapi.com/global/currency_rates") else{return}
        
        let headers = [
            "x-rapidapi-host": "currency-value.p.rapidapi.com",
            "x-rapidapi-key": "0a56714341mshcfa4870e99dbd68p1f4e03jsn984e83a81850"
        ]
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, _, err) in
            DispatchQueue.main.async {
                if err != nil{
                    print(err?.localizedDescription ?? "Error from serverRequest" )
                }else{
                    guard let data = data else{return}
                    do{
                        let decoder = JSONDecoder()
                        let object = try decoder.decode(Currency.self, from: data)
                        complition(object)
                    }catch{
                        print("serverRequestWithCurrencyStruct\(error.localizedDescription)")
                    }
                }
            }
        }.resume()
    }
}
/*
 let headers = [
 "x-rapidapi-host": "currency-value.p.rapidapi.com",
 "x-rapidapi-key": "0a56714341mshcfa4870e99dbd68p1f4e03jsn984e83a81850"
 ]
 
 let request = NSMutableURLRequest(url: NSURL(string: "https://currency-value.p.rapidapi.com/global/currency_rates")! as URL,
 cachePolicy: .useProtocolCachePolicy,
 timeoutInterval: 10.0)
 request.httpMethod = "GET"
 request.allHTTPHeaderFields = headers
 
 let session = URLSession.shared
 let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
 if (error != nil) {
 print(error)
 } else {
 let httpResponse = response as? HTTPURLResponse
 print(httpResponse)
 }
 })
 
 dataTask.resume()
 
 */
