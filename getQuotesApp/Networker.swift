//
//  Networker.swift
//  getQuotesApp
//
//  Created by Nguyễn Hữu Khánh on 17/03/2021.
//

import Foundation

enum NetworkerError: Error {
    case badResponse
    case badStatusCode(Int)
    case badData
}

class Networker {
    func getQuotes(competion: @escaping (Kanye?, Error?) -> ()) {
        
        let url = URL(string: "http://api.kanye.rest/")!
        
        let task = URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                DispatchQueue.main.async {
                    competion(nil, error)
                }
                return
            }
            
            guard let httpRespone = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    competion(nil, NetworkerError.badResponse)
                }
                return
            }
            guard (200...299).contains(httpRespone.statusCode) else {
                DispatchQueue.main.async {
                    competion(nil, NetworkerError.badStatusCode(httpRespone.statusCode))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    competion(nil, NetworkerError.badData)
                }
                return
            }
            
            do {
                let kanye = try JSONDecoder().decode(Kanye.self, from: data)
                DispatchQueue.main.async {
                    competion(kanye, nil)
                }
            } catch let error {
                DispatchQueue.main.async {
                    competion(nil, error)
                }
            }
        }
        task.resume()
    }
}
