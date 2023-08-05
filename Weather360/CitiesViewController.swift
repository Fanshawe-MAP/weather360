//
//  CitiesViewController.swift
//  Weather360
//
//  Created by Pawan Dharel on 7/28/23.
//

import UIKit

class CitiesViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var citiesArray: [ViewController.WeatherData] = []
    var isCelciusSelected : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onBackBtnPress(_ sender: UIButton) {
           dismiss(animated: true, completion: nil)
    }
    

}


extension CitiesViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return citiesArray.count
    }
    
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "uiTableViewCell", for: indexPath)
      
           
           let city = citiesArray[indexPath.row]
           var content = cell.defaultContentConfiguration()
           content.text = city.locationName
        content.secondaryText = String(isCelciusSelected ? city.tempCelsius : city.tempFahrenheit) + (isCelciusSelected ? "°C" : "°F")
           

        
        let (sfSymbolName, primaryColor, secondaryColor) = WeatherHelper.getWeatherSFIconData(for: city.conditionCode, isDay: city.isDay)
        cell.backgroundColor = city.isDay == 1 ? UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 0.9) : UIColor(red: 0, green: 0, blue: 0, alpha: 0.9)
   

        // Check if the SF Symbol name is available
        if let sfSymbolName = sfSymbolName {
           
            
            let config = UIImage.SymbolConfiguration(paletteColors: [primaryColor, secondaryColor])
            let symbolImage = UIImage(systemName:sfSymbolName, withConfiguration: config)
            content.image = symbolImage

            
        } else {
           print("there is an error in sfSymbol icon.")
        }
        // Set the text color based on whether it is daytime or nighttime
           if city.isDay == 1 {
               content.textProperties.color = UIColor.black
               content.secondaryTextProperties.color = UIColor.black
           } else {
               content.textProperties.color = UIColor.white
               content.secondaryTextProperties.color = UIColor.white
           }
        
        cell.contentConfiguration = content
        
           
           return cell
       }

    
    
}


