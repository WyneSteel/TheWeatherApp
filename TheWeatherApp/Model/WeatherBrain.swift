//
//  WeatherManager.swift
//  TheWeatherApp
//
//  Created by Wynelher Tagayuna on 3/21/23.
//

import Foundation
import UIKit

struct WeatherBrain{
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(latitude: String, longitude: String){// Fetch weather based on latitude and longitude of user location.
        let weatherURL = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=fd56c03abc50f4112b380b24154c9953&units=metric"
        performNetworking(using: weatherURL)
    }
    
    func fetchWeather(city name: String?){// Fetch weather based on city name input by user.
        if let unwrapName = name{
            let weatherURL = "https://api.openweathermap.org/data/2.5/weather?q=\(unwrapName)&appid=fd56c03abc50f4112b380b24154c9953&units=metric"
            performNetworking(using: weatherURL)
        }
    }
    
    func performNetworking(using urlString: String){
        // Create URL.
        if let url = URL(string: urlString){
            // Create URLSession.
            let session = URLSession(configuration: .default)
            // Give session a task.
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data{
                    if let weather = self.parseJSON(weatherData: safeData){
                        self.delegate?.didUpdateWeather(weather: weather)// Update UI.
                    }
                }
            }
            // Start task.
            task.resume()
        }
    }
    
    // Decode JSON Objects.
    func parseJSON(weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do{
            let decodedWeatherData = try decoder.decode(WeatherData.self, from: weatherData)// Unpack objects.
            let name = decodedWeatherData.name
            let temperature = decodedWeatherData.main.temp
            let weatherID = decodedWeatherData.weather[0].id
            
            let weatherModel = WeatherModel(cityName: name, cityTemperature: temperature, cityWeatherID: weatherID)// Get weather information.
            
            return weatherModel
        }catch{
            return nil
        }
    }
}

