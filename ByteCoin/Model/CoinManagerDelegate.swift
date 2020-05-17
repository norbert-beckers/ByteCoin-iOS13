//
//  CoinManagerDelegate.swift
//  ByteCoin
//
//  Created by Norbert Beckers on 16/05/2020.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCoin(_ manager: CoinManager, coin: CoinModel)
    func didFailWithError(_ manager: CoinManager, error: Error)
}
