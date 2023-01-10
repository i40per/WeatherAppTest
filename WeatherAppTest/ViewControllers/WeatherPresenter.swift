//
//  WeatherPresenter.swift
//  WeatherAppTest
//
//  Created by Evgenii Lukin on 07.01.2023.
//

import Foundation
import UIKit

protocol WeatherPresentLogic {
    func presentData(responce: WeatherEnum.Model.Response.ResponseType)
}

class WeatherPresenter: WeatherPresentLogic {
    
    weak var viewController: WeatherDisplayLogic?
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter
    }()
    
    func presentData(responce: WeatherEnum.Model.Response.ResponseType) {
        switch responce {
            
        case .presentWeather(weather: let weather, lacality: let locality):
            var hourlyCells: [CurrentWeatherViewModel.Hourly] = []
            var dailyCells: [CurrentWeatherViewModel.Daily] = []
            
            weather.hourly.forEach { hourly in
                hourlyCells.append(CurrentWeatherViewModel.Hourly.init(dt: formatterData(dateFormat: "HH", date: hourly.dt),
                                                                       temp: setSign(temp: Int(hourly.temp)),
                                                                       description: hourly.weather.debugDescription,
                                                                       icon: hourly.weather.first?.icon ?? "No Data"))
            }
            
            hourlyCells.removeLast(24)
            hourlyCells[0].dt = "Сейчас"
            
            
            weather.daily.forEach { daily in
                dailyCells.append(CurrentWeatherViewModel.Daily.init(dt: formatterData(dateFormat: "EEEE", date: daily.dt),
                                                                     minTemp: setSign(temp: Int(daily.temp.day)),
                                                                     maxTemp: setSign(temp: Int(daily.temp.night)),
                                                                     description: daily.weather.debugDescription,
                                                                     icon: daily.weather.first?.icon ?? "No Data", humidity: daily.humidity))
                
                dailyCells[0].dt = "Сегодня"
                let maxMinTemp = "H: \(dailyCells[0].maxTemp), L: \(dailyCells[0].minTemp)"
                let humidity = weather.current.humidity
                
                let currentWeather = headerViewModel(weatherModel: weather,
                                                     hourlyCells: hourlyCells,
                                                     maxMinTemp: maxMinTemp,
                                                     dailyCells: dailyCells,
                                                     locality: locality,
                                                     humidity: humidity)
                
                viewController?.displayData(viewModel: .displayWeather(currentWeatherViewModel: currentWeather))
                print(currentWeather)
            }
        }
    }
    
    
    private func formatterData(dateFormat: String, date: Double) -> String {
        dateFormatter.dateFormat = dateFormat
        let currentDate = NSDate(timeIntervalSince1970: date)
        let dateTitle = dateFormatter.string(from: currentDate as Date).capitalizedFirst()
        return dateTitle
    }
    
    private func setSign(temp: Int) -> String {
        var curTemp: String = ""
        
        guard temp > 1 else {
            curTemp = "\(temp)";
            return curTemp }
        curTemp = "\(temp)"
        return curTemp
    }
    
    private func headerViewModel(weatherModel: WeatherResponce, hourlyCells: [CurrentWeatherViewModel.Hourly], maxMinTemp: String, dailyCells: [CurrentWeatherViewModel.Daily], locality: String, humidity: Int) -> CurrentWeatherViewModel {
        return CurrentWeatherViewModel.init(locality: locality,
                                            temp: setSign(temp: Int(weatherModel.current.temp)),
                                            weatherDescription: weatherModel.current.weather.first?.description ?? "No data",
                                            icon: weatherModel.current.weather.first?.icon ?? "No data",
                                            maxMinLabel: maxMinTemp, humidity: humidity,
                                            hourlyWeather: hourlyCells,
                                            dailyWeather: dailyCells)
    }
}
