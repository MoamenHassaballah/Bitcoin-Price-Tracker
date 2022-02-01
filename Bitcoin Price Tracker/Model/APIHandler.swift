//
//  APIHandler.swift
//  Bitcoin Price Tracker
//
//  Created by Moamen Hassaballah on 01/02/2022.
//

import Foundation

class APIHandler {
    
    var delegate: PriceDelegate? = nil
    
    // Get your api key from here https://www.coinapi.io/
    let apiKey = "PUT_YOUR_API_KEY_HERE"
    let apiUrl = "https://rest.coinapi.io/v1/exchangerate/BTC/"
    
    func getPrice (_ currency: String) {
        
        let url = "\(apiUrl)\(currency)?apikey=\(apiKey)"
        performAPIRequest(url)
    }
    
    private func performAPIRequest(_ url:String){
        
        if let myUrl = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: myUrl) { (data, response, error) in
                if error != nil {
                    self.delegate?.onError(error: error!)
                    return
                }
                
                if let safeData = data {
                    self.parseData(safeData)
                }
            }
            
            task.resume()
            
        }
        
    }
    
    
    private func parseData(_ data: Data){
        let jsonDecoder = JSONDecoder()
        do {
            
            let price  = try jsonDecoder.decode(Prices.self, from: data)
            delegate?.onPriceRetrieved(price: price)
        }catch {
            delegate?.onError(error: error)

        }
    }
    
}
