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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(citiesArray)
        
        tableView.dataSource = self
        // Do any additional setup after loading the view.
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
           content.secondaryText = String(city.tempCelsius) + "°C"
//           content.image = UIImage(systemName: "sunny") // Replace "sfIcon" with the name of your SF symbol
           
      
        
        let (sfSymbolName, primaryColor, secondaryColor) = WeatherHelper.getWeatherSFIconData(for: city.conditionCode, isDay: city.isDay)
        cell.backgroundColor = city.isDay == 1 ? UIColor.white : UIColor.black

        // Check if the SF Symbol name is available
        if let sfSymbolName = sfSymbolName {
            // Create the SF Symbol image with two colors
            let symbol = UIImage(systemName: sfSymbolName)?
                .withTintColor(primaryColor)
                .withTintColor(secondaryColor, renderingMode: .alwaysOriginal)
            
                content.image = symbol
            
        } else {
            // Handle the case where the SF Symbol name is not found (nil).
            // For example, you can display a placeholder image or show an error message.
        }
        cell.contentConfiguration = content
           
           return cell
       }

    
    
}


