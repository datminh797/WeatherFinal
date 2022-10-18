//
//  WeatherManager.swift
//  WeatherFinal
//
//  Created by minhdat on 16/10/2022.
//

import Foundation
import CoreLocation

struct WeatherManager {
    let urlBase = "https://api.openweathermap.org/data/2.5/weather?appid=1fd678af3271feedc23ef64c288f9758&units=metric&"
    
    var delegate : WeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        let urlString = "\(urlBase)q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let urlString = "\(urlBase)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    
    func performRequest(with urlString : String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .ephemeral)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    let dataString = String(data: safeData, encoding: .utf8)
                    
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData : Data) -> WeatherModel?{
            let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temperature = decodedData.main.temp
            let humidity = decodedData.main.humidity
            
            return WeatherModel(conditionId: id, cityName: name, temperature: temperature, humidity: humidity)
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

protocol WeatherManagerDelegate{
    func didFailWithError(error: Error)
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
}

