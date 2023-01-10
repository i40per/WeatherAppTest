//
//  NetworkManager.swift
//  WeatherAppTest
//
//  Created by Evgenii Lukin on 06.01.2023.
//

import Foundation

class NetworkManager {
    
    enum RequestType {
        case cityName(city: [String])
    }
    
    var onCompletion: (([CurrentWeather]) -> Void)?
    
    static let shared = NetworkManager()
    private init() {}
    
    func fetchCurrentWeather(forRequestType requestType: RequestType) {
        var urlStrings = [String]()
        
        switch requestType {
        case .cityName(let citys):
            for city in citys {
               let urlString =
                "https://api.openweathermap.org/data/2.5/weather?q=\(city)&apikey=\(API.apiKey)&lang=ru&units=metric"
                urlStrings.append(urlString)
            }
        }
        performRequest(withURLString: urlStrings)
    }
    
    private func performRequest(withURLString urlStrings: [String]) {
        for urlString in urlStrings {
            guard let url = URL(string: urlString) else { return }
            let session = URLSession.shared
            let task = session.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    if let data = data {
                        if let currentWeather = self.parseJSON(withData: data) {
                            self.onCompletion?(currentWeather)
                        }
                    }
                }
                
            }
            task.resume()
        }
    }
    private func parseJSON(withData data: Data) -> [CurrentWeather]? {
         let decoder = JSONDecoder()
         
         do {
             let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
             guard let currentWeather = CurrentWeather(currentWeatherData: currentWeatherData)
             else { return nil }
             return [currentWeather]
             
         } catch let error as NSError {
             print(error.localizedDescription)
         }
         return nil
     }
 }
