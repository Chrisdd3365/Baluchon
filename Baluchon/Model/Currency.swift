//
//  Currency.swift
//  Baluchon
//
//  Created by Christophe DURAND on 22/08/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import Foundation

struct Currency: Decodable {
    let success: Bool
    let timestamp: Double
    let base: String
    let date: String
    let rates: Double
}

