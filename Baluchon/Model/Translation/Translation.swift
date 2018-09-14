//
//  Translation.swift
//  Baluchon
//
//  Created by Christophe DURAND on 13/09/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import Foundation

struct Data: Decodable {
    var data: Translations
}

struct Translations: Decodable {
    let translations: [TranslatedText]
}

struct TranslatedText: Decodable {
    let translatedText: String
}

struct SourceAndTarget {
    static var source = "fr"
    static var target = "en"
}

struct TextTranslated {
    var text: String
}
