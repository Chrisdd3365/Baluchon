//
//  TranslationService.swift
//  Baluchon
//
//  Created by Christophe DURAND on 21/08/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import UIKit

class TranslationService {
    
    //MARK: - Properties
    var task: URLSessionDataTask?
    private var translationSession: URLSession
    
    init(translationSession: URLSession = URLSession(configuration: .default)) {
        self.translationSession = translationSession
    }
    
    //MARK: - Methods
    private func urlTranslation(text: String, source: String, target: String) -> String {
        var translationURL: String
        guard let translationTextConverted = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return "" }
        translationURL = GoogleAPI.baseURL + GoogleAPI.key + GoogleAPI.source + source + GoogleAPI.target + target + GoogleAPI.format + GoogleAPI.query + translationTextConverted
        let url = translationURL
        return url
    }
    
    func getTranslation(text: String, source: String, target: String, callback: @escaping (Bool, Data?) -> Void) {
        guard let url = URL(string: urlTranslation(text: text, source: source, target: target)) else { return }
        task?.cancel()
        task = translationSession.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let translationResponseJSON = try? JSONDecoder().decode(Data.self, from: data) else {
                    callback(false, nil)
                    return
                }
                callback(true, translationResponseJSON)
            }
        }
        task?.resume()
    }
}
