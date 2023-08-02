//
//  ViewController.swift
//  Weather360
//
//  Created by Pawan Dharel on 7/26/23.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,UITextFieldDelegate,CLLocationManagerDelegate {
    
    @IBOutlet weak var SearchTxt: UITextField!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var weatherCondition: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var weatherImage: UIImageView!
    
    
    @IBOutlet weak var fahBtnLabel: UIButton!
    @IBOutlet weak var celBtnLabel: UIButton!
    
    var locationManager: CLLocationManager?
    
    struct CurrentLocationWrapper: Decodable {
        let location:locationData
        let current: currentLocationData
        
    }
    
    struct locationData: Decodable {
        let name: String
    }
    
    struct currentLocationData: Decodable {
        let temp_c: Double
        let temp_f: Double
        let is_day: Int
        let condition: conditionData
    }
    
    struct conditionData: Decodable {
        let text: String
        let code: Int
    }
    
    
    struct WeatherData {
        let locationName: String
        let tempCelsius: Double
        let tempFahrenheit: Double
        let conditionText: String
        let conditionCode: Int
        let isDay: Int
    }
    
    struct SearchHistory{
        var history:[WeatherData]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SearchTxt.delegate = self
        
       setupLocationManager()
        makeHidden(true)
        
       
    }
    
    func makeHidden(_ isTrue: Bool){
        weatherImage.isHidden = isTrue
        weatherCondition.isHidden = isTrue
        cityName.isHidden = isTrue
        weatherLabel.isHidden = isTrue
        fahBtnLabel.isHidden = isTrue
        celBtnLabel.isHidden = isTrue
        
    }
    
    
//    current location
    func setupLocationManager() {
         locationManager = CLLocationManager()
         locationManager?.delegate = self
         locationManager?.desiredAccuracy = kCLLocationAccuracyBest
         locationManager?.requestWhenInUseAuthorization()
     }
    
    
    
    @IBAction func onCurrentLocationPress(_ sender: UIButton) {
        locationManager?.startUpdatingLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.last {
                let latitude = location.coordinate.latitude
                let longitude = location.coordinate.longitude
                print("Latitude: \(latitude)\nLongitude: \(longitude)")
                
                searchWeather("\(latitude),\(longitude)")
                
            }
            locationManager?.stopUpdatingLocation()
        }

        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Location update error: \(error.localizedDescription)")
        }
    
    var searchHistory = SearchHistory(history: [])
    
    
    
    func parseJoke(data: Data) -> CurrentLocationWrapper? {
        let decoder = JSONDecoder()
        var wrapper: CurrentLocationWrapper?
        
        do{
            wrapper = try decoder.decode(CurrentLocationWrapper.self, from: data)
        }
        catch{
            print (error)
        }
        return wrapper
    }
    
    func getWeatherData(data:Data?,response:URLResponse?,error:Error?){
        
        guard error == nil else{
            print(error ?? "there is a error")
            return
        }
        
        guard let data = data else{
            print("No data received")
            return
        }
        
        
        if let locationWrapper = parseJoke(data: data){
//            print(locationWrapper.location.name)
            
            let weatherData = WeatherData(
                 locationName: locationWrapper.location.name,
                 tempCelsius: locationWrapper.current.temp_c,
                 tempFahrenheit: locationWrapper.current.temp_f,
                 conditionText: locationWrapper.current.condition.text,
                 conditionCode: locationWrapper.current.condition.code,
                 isDay: locationWrapper.current.is_day
             )

          
            searchHistory.history.append(weatherData)
         
          
            
            DispatchQueue.main.async {
                      self.weatherLabel.text = String(weatherData.tempCelsius)
                      self.weatherCondition.text = weatherData.conditionText
                      self.cityName.text = weatherData.locationName
                self.backgroundImage.image = UIImage(named: locationWrapper.current.is_day == 0 ? "night_background": "light_background")
                self.makeHidden(false)
                self.changeLabelColorWithDay(locationWrapper.current.is_day)
          
                  }

        }
    }
    

    
    func changeLabelColorWithDay(_ isDay: Int){
        let isDayTime: Bool = isDay == 1
        let colorMode = UIColor(ciColor:  isDayTime ?.blue : .white)
        weatherCondition.textColor = colorMode
        cityName.textColor = colorMode
//        weatherLabel.isHidden = isTrue
//        fahBtnLabel.isHidden = isTrue
//        celBtnLabel.isHidden = isTrue
    }

    
    func getUrl(_ location:String)->URL{
        
        let baseUrl="https://api.weatherapi.com/v1/current.json"
        let key="77e5f75f374648998f2225455232707"
        let locationParam = location.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let endPoint:String = "\(baseUrl)?q=\(locationParam)&key=\(key)"
        
        return URL(string: endPoint) ?? URL(string: "")!
    }
    
    
    @IBAction func onTemperatureInfoChange(_ sender: UISegmentedControl) {
        // Ensure there is at least one weather data in the search history
        guard let weatherData = searchHistory.history.last else {
            // If the search history is empty, return
            return
        }

        switch sender.selectedSegmentIndex {
        case 0:
            // Celsius is selected, update the temperature label with tempCelsius
            weatherLabel.text = String(weatherData.tempCelsius)
        case 1:
            // Fahrenheit is selected, update the temperature label with tempFahrenheit
            weatherLabel.text = String(weatherData.tempFahrenheit)
        default:
            break
        }
    }

    
    @IBAction func onCelciusBtnTap(_ sender: Any) {
        guard let weatherData = searchHistory.history.last else {
            // If the search history is empty, return
            return
        }
        weatherLabel.text = String(weatherData.tempCelsius)
        celBtnLabel.isSelected = true
        fahBtnLabel.isSelected = false
    }
    
    @IBAction func onFehBtnTap(_ sender: Any) {
        guard let weatherData = searchHistory.history.last else {
            // If the search history is empty, return
            return
        }
     
        weatherLabel.text = String(weatherData.tempFahrenheit)
        celBtnLabel.isSelected = false
        fahBtnLabel.isSelected = true
        
        
        
    }
    
    
    func searchWeather(_ searchText: String){
        // 1. Create URL
        let url: URL? = getUrl(searchText)

        // 2. Create URLsession

        let urlSession=URLSession(configuration: .default)
        
        // 3. Create task for URLsession
        if let url = url{
            let dataTask=urlSession.dataTask(with: url, completionHandler: getWeatherData(data:response:error:))

            // 4. Start task
            dataTask.resume()
        }
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Dismiss the keyboard when "Return" key is pressed
        textField.resignFirstResponder()

        // Perform your search operation or any other action here
        // For example, you can call your 'searchWeather' function
        searchWeather(SearchTxt.text ?? "")

        // Return 'true' to indicate that the 'Return' key press has been handled
        return true
    }
    
    @IBAction func onSearchBtnPress(_ sender: UIButton) {
        searchWeather(SearchTxt.text ?? "")
        
    }
      
    @IBAction func onCitiesPress(_ sender: UIButton) {
        performSegue(withIdentifier: "goToCitiesScreen", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToCitiesScreen" {
            if let citiesViewController = segue.destination as? CitiesViewController {
                citiesViewController.citiesArray = searchHistory.history // Pass the history array
            }
        }
    }


}
