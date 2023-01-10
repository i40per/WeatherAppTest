//
//  WeatherResponce.swift
//  WeatherAppTest
//
//  Created by Evgenii Lukin on 06.01.2023.
//

import Foundation

struct WeatherResponce: Decodable {
    
    let lat, lon: Double
    let current: Current
    let hourly: [HourlyWeather]
    let daily: [DailyWeather]

}

struct Current: Decodable {
    let humidity: Int
    let dt, temp: Double
    let sunrise, sunset: Int
    let weather: [WeatherInfo]
}

struct WeatherInfo: Decodable {
    let description, icon: String
}

struct HourlyWeather: Decodable {
    
    let dt, temp: Double
    let weather: [HourlyWeatherInfo]
}

struct HourlyWeatherInfo: Decodable {
    let description, icon: String
}

struct DailyWeather: Decodable {
    
    let dt: Double
    let temp: DailyTemp
    let weather: [DailyWeatherInfo]
    let humidity: Int
}

struct DailyTemp: Decodable {
    let day, night: Double
}

struct DailyWeatherInfo: Decodable {
    let icon: String
}
