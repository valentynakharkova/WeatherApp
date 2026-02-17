//
//  MockData.swift
//  WeatherApp
//
//  Created by Valentyna Kharkova on 14.02.2026.
//

import Foundation

// MARK: - Mock Weather Data
extension WeatherData {
    
    // DAY - Clear weather - Kyiv (12:00 PM)
    static var mock: WeatherData {
        WeatherData(
            coord: Coord(lon: 30.5241, lat: 50.45),
            weather: [
                Weather(
                    id: 800,
                    main: "Clear",
                    description: "clear sky",
                    icon: "01d"
                )
            ],
            base: "stations",
            main: Main(
                temp: 15.5,
                feelsLike: 14.2,
                tempMin: 12.0,
                tempMax: 18.0,
                pressure: 1013,
                humidity: 65,
                seaLevel: 1013,
                grndLevel: 995
            ),
            visibility: 10000,
            rain: nil,
            snow: nil,
            wind: Wind(
                speed: 3.5,
                gust: 5.2,
                deg: 180
            ),
            clouds: Clouds(all: 20),
            dt: 1739707200,  // Feb 16, 2026 - 12:00 PM (noon)
            sys: Sys(
                country: "UA",
                sunrise: 1739687400,  // 6:30 AM
                sunset: 1739727000     // 5:50 PM
            ),
            timezone: 7200,
            id: 703448,
            name: "Kyiv",
            cod: 200
        )
    }
    
    // GRAY - Rainy/Cloudy - Zaporizhzhia (2:00 PM)
    static var mockRain: WeatherData {
        WeatherData(
            coord: Coord(lon: 35.1396, lat: 47.8388),
            weather: [
                Weather(
                    id: 500,
                    main: "Rain",
                    description: "light rain",
                    icon: "10d"
                )
            ],
            base: "stations",
            main: Main(
                temp: 8.3,
                feelsLike: 6.1,
                tempMin: 6.0,
                tempMax: 10.5,
                pressure: 1008,
                humidity: 82,
                seaLevel: 1008,
                grndLevel: 990
            ),
            visibility: 8000,
            rain: Rain(
                oneHour: 2.5,
                threeHours: 5.0
            ),
            snow: nil,
            wind: Wind(
                speed: 5.2,
                gust: 8.5,
                deg: 220
            ),
            clouds: Clouds(all: 90),  // High clouds = gray
            dt: 1739714400,  // Feb 16, 2026 - 2:00 PM
            sys: Sys(
                country: "UA",
                sunrise: 1739687400,  // 6:30 AM
                sunset: 1739727000     // 5:50 PM
            ),
            timezone: 7200,
            id: 687700,
            name: "Zaporizhzhia",
            cod: 200
        )
    }
    
    // NIGHT - Snowy - Kyiv (10:00 PM)
    static var mockSnow: WeatherData {
        WeatherData(
            coord: Coord(lon: 30.5241, lat: 50.45),
            weather: [
                Weather(
                    id: 600,
                    main: "Snow",
                    description: "light snow",
                    icon: "13n"
                )
            ],
            base: "stations",
            main: Main(
                temp: -2.1,
                feelsLike: -5.3,
                tempMin: -4.0,
                tempMax: 0.5,
                pressure: 1015,
                humidity: 95,
                seaLevel: 1015,
                grndLevel: 998
            ),
            visibility: 2000,
            rain: nil,
            snow: Snow(
                oneHour: 0.8,
                threeHours: 2.1
            ),
            wind: Wind(
                speed: 4.1,
                gust: 7.2,
                deg: 280
            ),
            clouds: Clouds(all: 45),  // Lower clouds so night shows, not gray
            dt: 1739743200,  // Feb 16, 2026 - 10:00 PM
            sys: Sys(
                country: "UA",
                sunrise: 1739687400,  // 6:30 AM
                sunset: 1739727000     // 5:50 PM
            ),
            timezone: 7200,
            id: 703448,
            name: "Kyiv",
            cod: 200
        )
    }
    
    // GRAY - Cloudy - London (1:00 PM)
    static var mockCloudy: WeatherData {
        WeatherData(
            coord: Coord(lon: -0.1257, lat: 51.5085),
            weather: [
                Weather(
                    id: 804,
                    main: "Clouds",
                    description: "overcast clouds",
                    icon: "04d"
                )
            ],
            base: "stations",
            main: Main(
                temp: 10.2,
                feelsLike: 9.1,
                tempMin: 8.5,
                tempMax: 12.0,
                pressure: 1012,
                humidity: 75,
                seaLevel: 1012,
                grndLevel: 1008
            ),
            visibility: 10000,
            rain: nil,
            snow: nil,
            wind: Wind(
                speed: 4.5,
                gust: nil,
                deg: 240
            ),
            clouds: Clouds(all: 95),  // High clouds = gray
            dt: 1739710800,  // Feb 16, 2026 - 1:00 PM
            sys: Sys(
                country: "GB",
                sunrise: 1739691000,  // 7:30 AM (London)
                sunset: 1739724600     // 5:30 PM (London)
            ),
            timezone: 0,
            id: 2643743,
            name: "London",
            cod: 200
        )
    }
}

//import Foundation
//
//// MARK: - Mock Weather Data
//extension WeatherData {
//    
//    // Clear weather - Kyiv
//    static var mock: WeatherData {
//        WeatherData(
//            coord: Coord(lon: 30.5241, lat: 50.45),
//            weather: [
//                Weather(
//                    id: 800,
//                    main: "Clear",
//                    description: "clear sky",
//                    icon: "01d"
//                )
//            ],
//            base: "stations",
//            main: Main(
//                temp: 15.5,
//                feelsLike: 14.2,
//                tempMin: 12.0,
//                tempMax: 18.0,
//                pressure: 1013,
//                humidity: 65,
//                seaLevel: 1013,
//                grndLevel: 995
//            ),
//            visibility: 10000,
//            rain: nil,
//            snow: nil,
//            wind: Wind(
//                speed: 3.5,
//                gust: 5.2,
//                deg: 180
//            ),
//            clouds: Clouds(all: 20),
//            dt: 1708012800,
//            sys: Sys(
//                country: "UA",
//                sunrise: 1707977318,
//                sunset: 1708014947
//            ),
//            timezone: 7200,
//            id: 703448,
//            name: "Kyiv",
//            cod: 200
//        )
//    }
//    
//    // Rainy weather - Zaporizhzhia
//    static var mockRain: WeatherData {
//        WeatherData(
//            coord: Coord(lon: 35.1396, lat: 47.8388),
//            weather: [
//                Weather(
//                    id: 500,
//                    main: "Rain",
//                    description: "light rain",
//                    icon: "10d"
//                )
//            ],
//            base: "stations",
//            main: Main(
//                temp: 8.3,
//                feelsLike: 6.1,
//                tempMin: 6.0,
//                tempMax: 10.5,
//                pressure: 1008,
//                humidity: 82,
//                seaLevel: 1008,
//                grndLevel: 990
//            ),
//            visibility: 8000,
//            rain: Rain(
//                oneHour: 2.5,
//                threeHours: 5.0
//            ),
//            snow: nil,
//            wind: Wind(
//                speed: 5.2,
//                gust: 8.5,
//                deg: 220
//            ),
//            clouds: Clouds(all: 90),
//            dt: 1708012800,
//            sys: Sys(
//                country: "UA",
//                sunrise: 1707977318,
//                sunset: 1708014947
//            ),
//            timezone: 7200,
//            id: 687700,
//            name: "Zaporizhzhia",
//            cod: 200
//        )
//    }
//    
//    // Snowy weather - Kyiv
//    static var mockSnow: WeatherData {
//        WeatherData(
//            coord: Coord(lon: 30.5241, lat: 50.45),
//            weather: [
//                Weather(
//                    id: 600,
//                    main: "Snow",
//                    description: "light snow",
//                    icon: "13d"
//                )
//            ],
//            base: "stations",
//            main: Main(
//                temp: -2.1,
//                feelsLike: -5.3,
//                tempMin: -4.0,
//                tempMax: 0.5,
//                pressure: 1015,
//                humidity: 95,
//                seaLevel: 1015,
//                grndLevel: 998
//            ),
//            visibility: 2000,
//            rain: nil,
//            snow: Snow(
//                oneHour: 0.8,
//                threeHours: 2.1
//            ),
//            wind: Wind(
//                speed: 4.1,
//                gust: 7.2,
//                deg: 280
//            ),
//            clouds: Clouds(all: 100),
//            dt: 1708012800,
//            sys: Sys(
//                country: "UA",
//                sunrise: 1707977318,
//                sunset: 1708014947
//            ),
//            timezone: 7200,
//            id: 703448,
//            name: "Kyiv",
//            cod: 200
//        )
//    }
//    
//    // Cloudy weather - London
//    static var mockCloudy: WeatherData {
//        WeatherData(
//            coord: Coord(lon: -0.1257, lat: 51.5085),
//            weather: [
//                Weather(
//                    id: 804,
//                    main: "Clouds",
//                    description: "overcast clouds",
//                    icon: "04d"
//                )
//            ],
//            base: "stations",
//            main: Main(
//                temp: 10.2,
//                feelsLike: 9.1,
//                tempMin: 8.5,
//                tempMax: 12.0,
//                pressure: 1012,
//                humidity: 75,
//                seaLevel: 1012,
//                grndLevel: 1008
//            ),
//            visibility: 10000,
//            rain: nil,
//            snow: nil,
//            wind: Wind(
//                speed: 4.5,
//                gust: nil,
//                deg: 240
//            ),
//            clouds: Clouds(all: 95),
//            dt: 1708012800,
//            sys: Sys(
//                country: "GB",
//                sunrise: 1707984318,
//                sunset: 1708019547
//            ),
//            timezone: 0,
//            id: 2643743,
//            name: "London",
//            cod: 200
//        )
//    }
//}
//
// MARK: - Mock Forecast Data
extension ForecastData {
    static var mock: ForecastData {
        ForecastData(
            cod: "200",
            message: 0,
            cnt: 5,
            list: [
                // Day 1
                ForecastItem(
                    dt: 1708012800,
                    main: ForecastMain(
                        temp: 15.5,
                        feelsLike: 14.2,
                        tempMin: 12.0,
                        tempMax: 18.0,
                        pressure: 1013,
                        seaLevel: 1013,
                        grndLevel: 995,
                        humidity: 65,
                        tempKf: 0
                    ),
                    weather: [
                        Weather(id: 800, main: "Clear", description: "clear sky", icon: "01d")
                    ],
                    clouds: Clouds(all: 20),
                    wind: Wind(speed: 3.5, gust: 5.2, deg: 180),
                    visibility: 10000,
                    pop: 0.0,
                    rain: nil,
                    snow: nil,
                    sys: ForecastSys(pod: "d"),
                    dtTxt: "2024-02-15 12:00:00"
                ),
                // Day 2
                ForecastItem(
                    dt: 1708099200,
                    main: ForecastMain(
                        temp: 17.2,
                        feelsLike: 16.5,
                        tempMin: 14.0,
                        tempMax: 19.5,
                        pressure: 1015,
                        seaLevel: 1015,
                        grndLevel: 997,
                        humidity: 60,
                        tempKf: 0
                    ),
                    weather: [
                        Weather(id: 801, main: "Clouds", description: "few clouds", icon: "02d")
                    ],
                    clouds: Clouds(all: 25),
                    wind: Wind(speed: 2.8, gust: 4.2, deg: 190),
                    visibility: 10000,
                    pop: 0.1,
                    rain: nil,
                    snow: nil,
                    sys: ForecastSys(pod: "d"),
                    dtTxt: "2024-02-16 12:00:00"
                ),
                // Day 3
                ForecastItem(
                    dt: 1708185600,
                    main: ForecastMain(
                        temp: 12.3,
                        feelsLike: 11.2,
                        tempMin: 10.0,
                        tempMax: 14.5,
                        pressure: 1010,
                        seaLevel: 1010,
                        grndLevel: 992,
                        humidity: 75,
                        tempKf: 0
                    ),
                    weather: [
                        Weather(id: 500, main: "Rain", description: "light rain", icon: "10d")
                    ],
                    clouds: Clouds(all: 80),
                    wind: Wind(speed: 4.5, gust: 7.0, deg: 220),
                    visibility: 8000,
                    pop: 0.6,
                    rain: Rain(oneHour: 1.5, threeHours: 3.0),
                    snow: nil,
                    sys: ForecastSys(pod: "d"),
                    dtTxt: "2024-02-17 12:00:00"
                ),
                // Day 4
                ForecastItem(
                    dt: 1708272000,
                    main: ForecastMain(
                        temp: 8.1,
                        feelsLike: 6.2,
                        tempMin: 6.0,
                        tempMax: 10.0,
                        pressure: 1008,
                        seaLevel: 1008,
                        grndLevel: 990,
                        humidity: 80,
                        tempKf: 0
                    ),
                    weather: [
                        Weather(id: 501, main: "Rain", description: "moderate rain", icon: "10d")
                    ],
                    clouds: Clouds(all: 95),
                    wind: Wind(speed: 5.2, gust: 8.5, deg: 240),
                    visibility: 5000,
                    pop: 0.9,
                    rain: Rain(oneHour: 3.5, threeHours: 7.0),
                    snow: nil,
                    sys: ForecastSys(pod: "d"),
                    dtTxt: "2024-02-18 12:00:00"
                ),
                // Day 5
                ForecastItem(
                    dt: 1708358400,
                    main: ForecastMain(
                        temp: 10.5,
                        feelsLike: 9.8,
                        tempMin: 8.0,
                        tempMax: 12.5,
                        pressure: 1012,
                        seaLevel: 1012,
                        grndLevel: 994,
                        humidity: 70,
                        tempKf: 0
                    ),
                    weather: [
                        Weather(id: 803, main: "Clouds", description: "broken clouds", icon: "04d")
                    ],
                    clouds: Clouds(all: 65),
                    wind: Wind(speed: 3.8, gust: 6.0, deg: 200),
                    visibility: 10000,
                    pop: 0.2,
                    rain: nil,
                    snow: nil,
                    sys: ForecastSys(pod: "d"),
                    dtTxt: "2024-02-19 12:00:00"
                )
            ],
            city: City(
                id: 703448,
                name: "Kyiv",
                coord: Coord(lon: 30.5241, lat: 50.45),
                country: "UA",
                population: 2797553,
                timezone: 7200,
                sunrise: 1707977318,
                sunset: 1708014947
            )
        )
    }
}

// MARK: - Mock Geocoding Data
extension GeocodingData {
    
    // Need to add memberwise initializer for mocks
    init(name: String, localNames: [String: String]?, lat: Double, lon: Double, country: String, state: String?) {
        self.name = name
        self.localNames = localNames
        self.lat = lat
        self.lon = lon
        self.country = country
        self.state = state
    }
    
    static var mockKyiv: GeocodingData {
        GeocodingData(
            name: "Kyiv",
            localNames: ["uk": "Київ", "en": "Kyiv", "ru": "Киев"],
            lat: 50.4500336,
            lon: 30.5241361,
            country: "UA",
            state: nil
        )
    }
    
    static var mockZaporizhzhia: GeocodingData {
        GeocodingData(
            name: "Zaporizhzhia",
            localNames: ["uk": "Запоріжжя", "en": "Zaporizhzhia"],
            lat: 47.8388,
            lon: 35.1396,
            country: "UA",
            state: "Zaporizhzhia Oblast"
        )
    }
    
    static var mockList: [GeocodingData] {
        [mockKyiv, mockZaporizhzhia]
    }
}
