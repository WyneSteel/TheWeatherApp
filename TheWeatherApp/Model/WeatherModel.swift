//
//  WeatherModel.swift
//  TheWeatherApp
//
//  Created by Wynelher Tagayuna on 3/22/23.
//

import Foundation

struct WeatherModel{
    let cityName: String
    let cityTemperature: Double
    let cityWeatherID: Int
    
    var temperatureString: String{// Calculated property convert double into one decimal temperature string.
        return String(format: "%.1f", cityTemperature)
    }
    
    var getWeatherIconName: String{// Calculated property to get system SF Symbol name.
        switch cityWeatherID{
        case 200...232:
            return "cloud.bolt.rain"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud"
        default:
            return "ERROR"
        }
    }
}
