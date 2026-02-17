//
//  CitiesListView.swift
//  WeatherApp
//
//  Created by Valentyna Kharkova on 16.02.2026.
//

import SwiftUI

struct CitiesListView: View {
    
    let viewModel = WeatherViewModel()
    
    var body: some View {
        ZStack {
            // background
            BackgroundGradient(weather: viewModel.weatherData)
        }
    }
}

#Preview {
    CitiesListView()
}
