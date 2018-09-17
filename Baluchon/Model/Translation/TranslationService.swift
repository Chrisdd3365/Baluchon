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
    private func urlTranslation(text: String) -> String {
        var translationURL: String
        guard let translationTextConverted = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return "" }
        translationURL = GoogleAPI.baseURL + GoogleAPI.key + GoogleAPI.query + translationTextConverted
        let url = translationURL
        return url
    }
    
    private func createTranslationRequest(text: String) -> URLRequest {
        let url = URL(string: urlTranslation(text: text))!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let body = "&source=fr&target=en&format=text"
        request.httpBody = body.data(using: .utf8)
        
        return request
    }
    
    func getTranslation(text: String, callback: @escaping (Bool, Data?) -> Void) {
        let request = createTranslationRequest(text: text)
        task?.cancel()
        task = translationSession.dataTask(with: request) { data, response, error in
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
