//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Valentyna Kharkova on 13.02.2026.
//

import SwiftUI

struct WeatherView: View {
    
    @StateObject private var viewModel = WeatherViewModel()
    
    init(viewModel: WeatherViewModel = WeatherViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                // background
                BackgroundGradient(weather: viewModel.weatherData)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 30) {
                        //MARK: Current Weather Data
                        if let weather = viewModel.weatherData {
                            TempereatureView(weather: weather)
                            
                            //MARK: Hourly Forecast
                            if let forecast = viewModel.forecastData {
                                HourlyForecastView(forecast: forecast)

                            }
                            
                            //MARK: Daily Forecast
                            if let dailyForecast = viewModel.forecastData {
                                DailyForecastView(forecast: dailyForecast)
                            }
                            
                            WeatherDetailsGrid(weather: weather)

                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        NavigationLink {
                            CitiesListView()
                        } label: {
                            Image(systemName: "list.bullet")
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink {
                            SearchView(viewModel: viewModel)
                        } label: {
                            Image(systemName: "magnifyingglass")
                        }
                    }
                }
            }
        }
        
    }
}


#Preview {
    WeatherView(viewModel: .init())
        
}

#Preview("With Weather") {
    @Previewable @State var vm = WeatherViewModel()
    vm.weatherData = .mock
    vm.forecastData = .mock
    return WeatherView(viewModel: vm)
}

#Preview("With Clouds") {
    @Previewable @State var vm = WeatherViewModel()
    vm.weatherData = .mockCloudy
    vm.forecastData = .mock
    return WeatherView(viewModel: vm)
}

#Preview("With Rain") {
    @Previewable @State var vm = WeatherViewModel()
    vm.weatherData = .mockRain
    vm.forecastData = .mock
    return WeatherView(viewModel: vm)
}

#Preview("With Snow") {
    @Previewable @State var vm = WeatherViewModel()
    vm.weatherData = .mockSnow
    vm.forecastData = .mock
    return WeatherView(viewModel: vm)
}

