//
//  CurrentWeatherData.swift
//  WeatherAppTest
//
//  Created by Evgenii Lukin on 06.01.2023.
//

import Foundation

struct CurrentWeatherData: Codable {
    
    let main: Main
    let name: String
    let timezone: Int
    let dt: Int
    let weather: [Weather]
}

struct Main: Codable {
    
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct Weather: Codable {
    
    let icon: String
    let weatherDescription: String
    
    enum CodingKeys: String, CodingKey {
        case weatherDescription = "description"
        case icon
    }
    
    var myDescription: String {
        
        switch weatherDescription {
        case "clear sky":
            return "Ясно"
        case "few clouds":
            return "Облачно"
        case "scattered clouds":
            return "Облачно"
        case "broken clouds":
            return "Облачно"
        case "shower rain":
            return "Сильный дождь"
        case "rain":
            return "Дождь"
        case "thunderstorm":
            return "Гроза"
        case "snow":
            return "Снег"
        case "mist":
            return "Туман"
        default: return "No data"
        }
    }
}
