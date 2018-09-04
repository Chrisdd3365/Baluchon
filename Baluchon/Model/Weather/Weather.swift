//
//  Weather.swift
//  Baluchon
//
//  Created by Christophe DURAND on 04/09/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import Foundation

struct Weather: Decodable {
    let date: String?
    let temp: String?
    let text: String?
}
