//
//  DailyForecastView.swift
//  WeatherApp
//
//  Created by Valentyna Kharkova on 15.02.2026.
//

import SwiftUI

struct DailyForecastView: View {
    
    let forecast: ForecastData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("5-DAY FORECAST")
                .font(.callout)
                .colorModifier()
            
            VStack(spacing: 12) {
                ForEach(getDailyForecast()) { item in
                    DailyForecastRow(item: item)
                }
            }
        }
        .padding()
    }
    //MARK: Get Daily Forecast
    private func getDailyForecast() -> [ForecastItem] {
        var dailyForecasts: [ForecastItem] = []
        var seenDates: Set<String> = []
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // Get one forecast per day (around noon time)
        for item in forecast.list {
            let dateString = dateFormatter.string(from: item.date)
            
            //Take forecast closet to 12:00 (noon)
            if !seenDates.contains(dateString) && item.dtTxt.contains("12:00:00") {
                dailyForecasts.append(item)
                seenDates.insert(dateString)
            }
        }
        return Array(dailyForecasts.prefix(5))
    }
}

#Preview {
    ZStack {
        BackgroundGradient()
        DailyForecastView(forecast: .mock)
    }
}
