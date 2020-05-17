//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct CoinManager {
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "4C9C58B4-56F6-4A2D-A911-6DBFF84431C7"
    
    let currencyArray = ["AUD", "BRL", "CAD", "CNY", "EUR", "GBP", "HKD", "IDR", "ILS", "INR", "JPY", "MXN", "NOK", "NZD", "PLN", "RON", "RUB", "SEK", "SGD", "USD", "ZAR"]

    var delegate: CoinManagerDelegate?
    
    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        let urlStringWithApiKey = "\(urlString)?apikey=\(apiKey)"
        
        if let url = URL(string: urlStringWithApiKey) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, _, error) in
                if let realError = error {
                    self.delegate?.didFailWithError(self, error: realError)
                } else {
                    if let safeData = data {
                        if let model = self.parseJSON(data: safeData) {
                            self.delegate?.didUpdateCoin(self, coin: model)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(data: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            return CoinModel(exchangeRate: decodedData.rate, currency: decodedData.asset_id_quote)
        } catch {
            delegate?.didFailWithError(self, error: error)
            return nil
        }
    }
}
