# WeatherApp 🌤️

A clean and minimal iOS weather app built with SwiftUI and Combine. 
WeatherApp lets you track real-time weather conditions for up to 5 cities 
at once, with a beautiful dynamic background that changes based on current 
weather conditions. Built as a personal learning project to practice 
SwiftUI, REST APIs, and MVVM architecture.

Whether you're planning your day or just curious about the weather in 
another city, WeatherApp gives you everything you need at a glance — 
current temperature, hourly and 5-day forecasts, and detailed weather 
metrics like humidity, wind speed, and pressure.

## Screenshots

## Icon
![Image](https://github.com/user-attachments/assets/c109e8f8-5c96-405a-b144-b92fd6a50423)

## Weather View
<img width="660" height="1434" alt="Image" src="https://github.com/user-attachments/assets/8ac6d351-b81d-4118-b5eb-894661710bad" />

## Cities View
<img width="660" height="1434" alt="Image" src="https://github.com/user-attachments/assets/72b6daad-b403-4c62-8aff-70c49e638a96" />

## Cities Search
<img width="660" height="1434" alt="Image" src="https://github.com/user-attachments/assets/114c4afb-36c8-4947-b533-3e08c5e4a5b8" />

## Cities List
<img width="660" height="1434" alt="Image" src="https://github.com/user-attachments/assets/58fe3c99-f83e-4b44-b136-76ab0c988a7b" />

## Cities List Limit Reached
<img width="660" height="1434" alt="Image" src="https://github.com/user-attachments/assets/273343ba-3ddc-4107-a7b7-f08de49a8c32" />

## City Weather View Cloudy
<img width="660" height="1434" alt="Image" src="https://github.com/user-attachments/assets/80b9af39-ca74-42ef-8638-98405fc7a9ba" />

## City Weather View Details
<img width="660" height="1434" alt="Image" src="https://github.com/user-attachments/assets/5427774e-f148-45ac-b905-62ae6bc057ee" />

## City Weather View Sunny
<img width="660" height="1434" alt="Image" src="https://github.com/user-attachments/assets/8d531d5a-e2a5-4a89-aa92-c271d76e1549" />

## City Weather View Night
<img width="660" height="1434" alt="Image" src="https://github.com/user-attachments/assets/fdd45f3e-e905-4383-a6af-b6d032deb7cc" />

## City Weather View Fahrenheit
<img width="660" height="1434" alt="Image" src="https://github.com/user-attachments/assets/75f42b2f-cf16-435f-91f1-1ba46a22615d" />

## City Weather View Fahrenheit Details
<img width="660" height="1434" alt="Image" src="https://github.com/user-attachments/assets/a0a437b7-22dd-4819-89f6-f02b5a9c2c7c" />

## Weather App Video Screenshot

https://github.com/user-attachments/assets/7922d326-9dbb-43c0-9ec9-a43c56eb0dde

## Features
- 🔍 Search and save up to 5 cities worldwide
- 📍 Current weather with dynamic background
- ⏱️ 3-hour forecast
- 📅 5-day forecast
- 🌡️ Celsius / Fahrenheit toggle
- 🌅 Sunrise & Sunset times (per city timezone)
- 💧 Humidity, wind speed, pressure, visibility
- 🔄 Swipe between saved cities
- 🗂️ Reorder and delete saved cities


## Tech Stack
- SwiftUI
- OpenWeatherMap API
- Combine
- MVVM Architecture

## Requirements
- iOS 26.0+
- Xcode 16+
- OpenWeatherMap API key (free tier)

## Setup
1. Clone the repo
2. Get a free API key from [openweathermap.org](https://openweathermap.org)
3. Add your key in `WeatherService.swift`
4. Run the project

## What I Learned
- Working with REST APIs and JSON decoding with `Codable`
- MVVM architecture in SwiftUI to keep views clean and logic separate
- Handling timezones correctly with UTC offsets from the API
- Unit testing with XCTest to verify temperature conversion logic
- Managing state across multiple views with `ObservableObject` and `@Published`
- Using `async/await` and parallel network requests with `async let`
- Building reusable SwiftUI components and custom view modifiers
- Persisting user data locally with `UserDefaults`
- Handling edge cases like empty states, loading states and API errors
- Working with `TabView`, `NavigationStack`, and `ScrollView` layouts
- Animating background gradients based on live weather conditions
- Converting and formatting raw API data (timestamps, temperatures, units)

## Tools & Resources
- [Claude by Anthropic](https://claude.ai) — used as an AI coding assistant
  throughout the project. Helped with generating code, explaining concepts, 
  debugging issues, and guidance on best practices. All code was reviewed,
  understood and integrated by me.
- [OpenWeatherMap API](https://openweathermap.org/api) — weather data
- [SF Symbols](https://developer.apple.com/sf-symbols/) — icons

## Author
Made by Valentyna 👩‍💻
