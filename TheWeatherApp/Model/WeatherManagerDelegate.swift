//
//  WeatherManagerDelegate.swift
//  TheWeatherApp
//
//  Created by Wynelher Tagayuna on 3/22/23.
//

import Foundation

protocol WeatherManagerDelegate{// Protocol for making the WeatherBrain struct reusable to any ViewControllers.
    func didUpdateWeather(weather: WeatherModel)// Update UI.
    func didFailWithError(error: Error)// For error handling.
}
