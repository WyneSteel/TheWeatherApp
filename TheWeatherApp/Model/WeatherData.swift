//
//  WeatherData.swift
//  TheWeatherApp
//
//  Created by Wynelher Tagayuna on 3/22/23.
//

import Foundation

// Decode into swift objects.
struct WeatherData: Codable{
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable{
    let temp: Double
}
struct Weather: Codable{
    let id: Int
}
