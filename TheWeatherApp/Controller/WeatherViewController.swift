//
//  ViewController.swift
//  TheWeatherApp
//
//  Created by Wynelher Tagayuna on 3/18/23.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var locationButton: UIButton!// Location button.
    @IBOutlet weak var searchButton: UIButton!// Search button.
    @IBOutlet weak var cityNameOutlet: UILabel!// City name.
    @IBOutlet weak var searchTextFieldOutlet: UITextField!// Search bar.
    @IBOutlet weak var weatherIconOutlet: UIImageView!// Weather icon.
    @IBOutlet weak var temperatureOutlet: UILabel!// Metric temperature.
    
    var weatherBrain = WeatherBrain()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()// Ask permission for location services.
        locationManager.requestLocation()// Request user current location.
        
        searchTextFieldOutlet.delegate = self
        weatherBrain.delegate = self
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        searchTextFieldOutlet.endEditing(true)// Resign search bar textfield.
    }
    
    @IBAction func currentLocationButton(_ sender: UIButton) {
        locationManager.requestLocation()// Request user current location.
    }
}

//MARK: - UITextFieldDelegate Protocol Section
extension WeatherViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextFieldOutlet.endEditing(true)// Resign search bar textfield.
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            textField.placeholder = "Search"
            return true
        }else{// If search bar textfield is still empty after user interaction.
            textField.placeholder = "Enter City"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        weatherBrain.fetchWeather(city: searchTextFieldOutlet.text)// Fetch weather based on city name input by user.
        searchTextFieldOutlet.text = ""
    }
}

//MARK: - WeatherManagerDelegate Protocol Section
extension WeatherViewController: WeatherManagerDelegate{
    func didUpdateWeather(weather: WeatherModel){// Update UI.
        DispatchQueue.main.async {// Change UI on the background.
            self.weatherIconOutlet.image = UIImage(systemName: weather.getWeatherIconName)// Weather icon.
            self.temperatureOutlet.text = weather.temperatureString+"°C"// Metric temperature.
            self.cityNameOutlet.text = weather.cityName// City name.
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}

extension WeatherViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {// Called if location fix is succesful.
        if let location = locations.last{
            locationManager.stopUpdatingLocation()// Stop location updates
            let lat = String(location.coordinate.latitude)
            let lon = String(location.coordinate.longitude)
            weatherBrain.fetchWeather(latitude: lat, longitude: lon)// Fetch weather based on latitude and longitude of user location.
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {// Called if location fix failed.
        print(error)
    }
    
    
}


