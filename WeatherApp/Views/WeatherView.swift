//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Valentyna Kharkova on 13.02.2026.
//

import SwiftUI
import Combine

struct WeatherView: View {
    
    @StateObject private var viewModel = WeatherViewModel()
    
    @State private var searchID = UUID()
        
    init() {
        _viewModel = StateObject(wrappedValue: WeatherViewModel())
    }
    
    init(viewModel: WeatherViewModel) {
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
                            CitiesListView(viewModel: viewModel)
                                .id(searchID)
                        } label: {
                            Image(systemName: "list.bullet")
                        }
                    }
                }
            }
            .onAppear {
                searchID = UUID()
            }
        }
        
    }
}


#Preview {
    WeatherView()
        
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

