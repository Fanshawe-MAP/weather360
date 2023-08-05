//
//  WeatherHelper.swift
//  Weather360
//
//  Created by Pawan Dharel on 7/28/23.
//


import UIKit

struct WeatherHelper {
    static func getWeatherSFIconData(for code: Int, isDay: Int) -> (name: String?, color: UIColor, secondaryColor: UIColor) {
        var primaryColor: UIColor
        var secondaryColor: UIColor
        
        if isDay == 0 {
            primaryColor = .gray
            secondaryColor = .white
        } else {
            primaryColor =  .white
            secondaryColor = .orange
        }
        
      
        
        switch code {
        case 1000:
            return (isDay == 1 ? "sun.max.fill" : "moon.fill", primaryColor, secondaryColor)
        case 1003:
            return (isDay == 1 ? "cloud.sun.fill" : "cloud.moon.fill", primaryColor, secondaryColor)
        case 1006:
            return ("cloud.fill", primaryColor, secondaryColor)
        case 1009:
            return ("smoke.fill", primaryColor, secondaryColor)
        case 1030:
            return ("cloud.fog.fill", primaryColor, secondaryColor)
        case 1063:
            return ("cloud.drizzle.fill", primaryColor, secondaryColor)
        case 1066:
            return ("cloud.snow.fill", primaryColor, secondaryColor)
        case 1069:
            return ("cloud.sleet.fill", primaryColor, secondaryColor)
        case 1072:
            return ("cloud.hail.fill", primaryColor, secondaryColor)
        case 1087:
            return ("cloud.bolt.fill", primaryColor, secondaryColor)
        case 1114:
            return ("wind.snow", .white, .blue)
        case 1117:
            return ("wind.snow", .white, .blue)
        case 1135:
            return ("cloud.fog.fill", primaryColor, secondaryColor)
        case 1147:
            return ("cloud.fog.fill", primaryColor, secondaryColor)
        case 1150:
            return ("cloud.drizzle.fill", primaryColor, secondaryColor)
        case 1153:
            return ("cloud.drizzle.fill", primaryColor, secondaryColor)
        case 1168:
            return ("cloud.hail.fill", primaryColor, secondaryColor)
        case 1171:
            return ("cloud.hail.fill", primaryColor, secondaryColor)
        case 1180:
            return ("cloud.rain.fill", primaryColor, secondaryColor)
        case 1183:
            return ("cloud.rain.fill", primaryColor, secondaryColor)
        case 1186:
            return ("cloud.rain.fill", primaryColor, secondaryColor)
        case 1189:
            return ("cloud.rain.fill", primaryColor, secondaryColor)
        case 1192:
            return ("cloud.heavyrain.fill", primaryColor, secondaryColor)
        case 1195:
            return ("cloud.heavyrain.fill", primaryColor, secondaryColor)
        case 1198:
            return ("cloud.hail.fill", primaryColor, secondaryColor)
        case 1201:
            return ("cloud.hail.fill", primaryColor, secondaryColor)
        case 1204:
            return ("cloud.sleet.fill", primaryColor, secondaryColor)
        case 1207:
            return ("cloud.sleet.fill", primaryColor, secondaryColor)
        case 1210:
            return ("cloud.snow.fill", primaryColor, secondaryColor)
        case 1213:
            return ("cloud.snow.fill", primaryColor, secondaryColor)
        case 1216:
            return ("cloud.snow.fill", primaryColor, secondaryColor)
        case 1219:
            return ("cloud.snow.fill", primaryColor, secondaryColor)
        case 1222:
            return ("cloud.snow.fill", primaryColor, secondaryColor)
        case 1225:
            return ("cloud.snow.fill", primaryColor, secondaryColor)
        case 1237:
            return ("cloud.hail.fill", primaryColor, secondaryColor)
        case 1240:
            return ("cloud.rain.fill", primaryColor, secondaryColor)
        case 1243:
            return ("cloud.heavyrain.fill", primaryColor, secondaryColor)
        case 1246:
            return ("cloud.heavyrain.fill", primaryColor, secondaryColor)
        case 1249:
            return ("cloud.sleet.fill", primaryColor, secondaryColor)
        case 1252:
            return ("cloud.sleet.fill", primaryColor, secondaryColor)
        case 1255:
            return ("cloud.snow.fill", primaryColor, secondaryColor)
        case 1258:
            return ("cloud.snow.fill", primaryColor, secondaryColor)
        case 1261:
            return ("cloud.hail.fill", primaryColor, secondaryColor)
        case 1264:
            return ("cloud.hail.fill", primaryColor, secondaryColor)
        case 1273:
            return ("cloud.bolt.rain.fill", primaryColor, secondaryColor)
        case 1276:
            return ("cloud.bolt.rain.fill", primaryColor, secondaryColor)
        case 1279:
            return ("cloud.bolt.snow.fill", primaryColor, secondaryColor)
        case 1282:
            return ("cloud.bolt.snow.fill", primaryColor, secondaryColor)
        default:
            return (nil, .black, .white) // Return nil for the SF Symbol name if no match is found
        }
    }
    
}
