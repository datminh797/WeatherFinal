//
//  WeatherModel.swift
//  WeatherFinal
//
//  Created by minhdat on 16/10/2022.
//

import Foundation

struct WeatherModel {
    let conditionId : Int
    let cityName : String
    let temperature : Double
    var humidity : Double
    
    var temperatureString : String {
        return String(format: "%.1f", temperature)
    }
    
    var humidityString : String {
        return String(format: "%.1f", humidity)
    }
    
    func getConditionName(conditionID : Int) -> String {
        switch conditionID {
        case 200...232 :
            return "cloud.bolt"
        case 300...321 :
            return "cloud.drizzle"
        case 500...531 :
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}

