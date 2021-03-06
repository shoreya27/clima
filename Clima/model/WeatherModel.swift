//
//  WeatherModel.swift
//  Clima
//
//  Created by user197822 on 6/13/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let temp:Double
    let id:Int
    let name:String
    
    var tempString:String{
        return String(format: "%.2f", temp)
    }
    
    var condition:String{
        switch id {
                case 200...232:
                    return "cloud.bolt"
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
                    return "cloud.bolt"
                default:
                    return "cloud"
                }
        }
}
