import UIKit

class WeatherViewController: UIViewController{

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
}

//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate{
    
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
    
}

//MARK: - WEATHERMANAGERDELEGATE
extension WeatherViewController:WeatherManagerDelegate{
    
    func updateWeather(_ weatherManager: WeatherManager, weather : WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.tempString
            self.conditionImageView.image = UIImage(systemName: weather.condition)
            self.cityLabel.text = weather.name
        }
    }
    func throwTheError(_ error: Error) {
        print(error)
    }
    
}
