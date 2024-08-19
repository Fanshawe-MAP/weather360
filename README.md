# Weather360

Weather360 is a simple iOS application built using Swift and Storyboard. The app fetches real-time weather data from a weather API and displays it to users. Users can search for weather conditions by entering a city name or by using their current location. The app also allows users to view the weather in Celsius or Fahrenheit.

## Features

- **Real-time Weather Data:** Fetches and displays weather information for a given location.
- **Current Location:** Users can get weather updates based on their current location.
- **Search Functionality:** Users can search for weather conditions in different cities.
- **Temperature Units:** Switch between Celsius and Fahrenheit.
- **Search History:** Keeps a history of previous searches and allows users to revisit the weather data for those locations.

## Technology Stack

- **Swift:** The primary programming language used for iOS development.
- **UIKit:** For building the app's user interface.
- **CoreLocation:** To fetch the user's current location.
- **Weather API:** Integrated to fetch real-time weather data.
- **Auto Layout:** To ensure the app UI works seamlessly across various iOS devices.
- **Git:** Version control for source code management.

## Installation

1. Clone the repository:

    ```bash
    git clone https://github.com/yourusername/Weather360.git
    ```

2. Open the project in Xcode:

    ```bash
    cd Weather360
    open Weather360.xcodeproj
    ```

3. Run the app on your preferred simulator or device:

    ```bash
    cmd + R
    ```

## Usage

- **Search by City:** Enter the city name in the search bar and press the search button to get the weather data.
- **Current Location:** Tap on the current location button to fetch weather data based on your GPS location.
- **Switch Units:** Use the Celsius and Fahrenheit buttons to switch between units.
- **View Search History:** Tap on the 'Cities' button to view the list of previously searched locations.

## Code Structure

- **WeatherHelper.swift:** A utility struct that provides weather icon data based on the weather code and time of day (day or night).
- **CitiesViewController.swift:** Displays a list of cities previously searched by the user. Allows switching between Celsius and Fahrenheit for each city.
- **ViewController.swift:** The main view controller of the app. Manages the search input, weather display, and current location updates. Handles API requests and data parsing.

## Models

- **CurrentLocationWrapper, locationData, currentLocationData, conditionData, WeatherData:** Structs to model the data returned by the weather API.

## Team Members

- **Pawan Dharel:** 1159158
- **Rajeev Sharma:** 1148536
- **Anup Saud:** 1149683

## API Integration

The app uses the WeatherAPI to fetch weather data. Make sure you replace the `key` variable in `ViewController.swift` with your own API key from WeatherAPI.

```swift
let key = "your_api_key_here"
