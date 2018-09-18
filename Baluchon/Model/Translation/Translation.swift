//
//  Translation.swift
//  Baluchon
//
//  Created by Christophe DURAND on 13/09/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import Foundation

//Google Translate API structure 
struct Data: Decodable {
    var data: Translations
}

struct Translations: Decodable {
    let translations: [TranslatedText]
}

struct TranslatedText: Decodable {
    let translatedText: String
}

