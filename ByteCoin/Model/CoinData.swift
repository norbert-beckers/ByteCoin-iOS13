//
//  CurrencyData.swift
//  ByteCoin
//
//  Created by Norbert Beckers on 16/05/2020.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData: Decodable {
    let asset_id_quote: String
    let rate: Double
}
