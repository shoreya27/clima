//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate{

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var searchFieldText: UITextField!
    
    var weatherManager = WeatherManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchFieldText.delegate = self
        weatherManager.delegate = self
    }

    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchFieldText.endEditing(true)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {

        if textField.text != "" {
            return true
        }else{
            textField.placeholder = "enter some text"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = textField.text {
            weatherManager.fetchWeather(city: city)
        }
        textField.text = ""
        textField.placeholder = "search"
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        searchFieldText.endEditing(true)
        return true
    }
    func updateWeather(_ weatherManager: WeatherManager, weather : WeatherModel) {
        print(weather.temp)
    }
    
    func throwTheError(_ error: Error) {
        print(error)
    }
    
}

