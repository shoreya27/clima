//
//  WeatherManager.swift
//  Clima
//
//  Created by user197822 on 6/12/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//
import Foundation
struct WeatherManager {
    
    let url =
        "https://api.openweathermap.org/data/2.5/weather?&appid=7a4cfe3f22b35dbda97673ec7d6dbd89&units=metric"
    
    func fetchWeather(city : String){
        let fetch = "\(url)&q=\(city)"
        //  print(fetch)
        fetchCityWeather(url: fetch)
    }
    
    func fetchCityWeather(url : String){
        //4 steps to fetch the request
        //1 create a url object
        if let url = URL(string: url){
            //2 create session object
            let session = URLSession(configuration: .default)
            //3 create datatask for get request
            let task = session.dataTask(with: url){
                                            (data, response, error) in
                                            if error != nil {
                                                print(error!)
                                                return
                                            }
                                            if let safedata = data{
                                                parseJson(data:safedata)
                                            }
            }
            task.resume()
        }
    }
    
    func parseJson(data: Data){
        let decoder = JSONDecoder()
        do {
            let datadecode = try decoder.decode(WeatherData.self, from: data)
            print(datadecode.name)
            print(datadecode.main.temp)
            print(datadecode.weather[0].description)
        }catch{
            print()
        }
    }
}
