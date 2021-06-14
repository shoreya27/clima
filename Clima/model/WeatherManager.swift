//
//  WeatherManager.swift
//  Clima
//
//  Created by user197822 on 6/12/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//
import Foundation
protocol WeatherManagerDelegate {
    func updateWeather(_ weatherManager: WeatherManager, weather : WeatherModel)
    func throwTheError(_ error: Error)
}

struct WeatherManager {
    
    let url =
        "https://api.openweathermap.org/data/2.5/weather?&appid=7a4cfe3f22b35dbda97673ec7d6dbd89&units=metric"
    
    var delegate : WeatherManagerDelegate?
    
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
                                                delegate?.throwTheError(error!)
                                                return
                                            }
                                            if let safedata = data{
                                                if  let weathermodel = parseJson(safedata){
                                                    delegate?.updateWeather(self, weather: weathermodel)
                                                }
                                            }
            }
            task.resume()
        }
    }
    
    func parseJson(_ data: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do {
            let datadecode = try decoder.decode(WeatherData.self, from: data)
            let id = datadecode.weather[0].id
            let temp = datadecode.main.temp
            let name = datadecode.name
            let weatherModel = WeatherModel(temp: temp,
                                            id: id,
                                            name: name)
            return weatherModel
        }catch{
            delegate?.throwTheError(error)
            return nil
        }
    }
    
}
