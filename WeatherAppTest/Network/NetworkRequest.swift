//
//  NetworkRequest.swift
//  WeatherAppTest
//
//  Created by Evgenii Lukin on 06.01.2023.
//

import Foundation

protocol NetworkRequestProtocol {
    
    func getWeather(coordinates: String, completion: @escaping (WeatherResponce?) -> Void)
}

struct NetworkRequest: NetworkRequestProtocol {
    func getWeather(coordinates: String, completion: @escaping (WeatherResponce?) -> Void) {
        
        let fullURL = "\(API.url)\(coordinates)"
        guard let url = URL(string: fullURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error requesting data: \(error.localizedDescription)")
                completion(nil)
            }
            let decoded = self.decodeJSON(type: WeatherResponce.self, from: data)
            completion(decoded)
        }
        .resume()
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let data = from, let response = try? decoder.decode(type.self, from: data) else { return nil}
        return response
    }
}
