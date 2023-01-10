//
//  WeatherModel.swift
//  WeatherAppTest
//
//  Created by Evgenii Lukin on 06.01.2023.
//

import Foundation

enum WeatherEnum {
    
    enum Model {
        struct Request {
            enum RequestType {
                case getWeather
            }
        }
        
        struct Response {
            enum ResponseType {
                case presentWeather(weather: WeatherResponce, lacality: String)
            }
        }
        
        struct ViewModel {
            enum ViewModelData {
                case displayWeather(currentWeatherViewModel: CurrentWeatherViewModel)
                
            }
        }
    }
}

struct CurrentWeatherViewModel {
    
    let locality: String
    let temp: String
    let weatherDescription: String
    let icon: String
    let maxMinLabel: String
    let humidity: Int
    let hourlyWeather: [Hourly]
    let dailyWeather: [Daily]
    
    struct Hourly {
        
        var dt: String
        let temp: String
        let description: String
        let icon: String
    }
    
    struct Daily {
        
        var dt: String
        let minTemp: String
        let maxTemp: String
        let description: String
        let icon: String
        let humidity: Int
    }
}
