//
//  HourlyForecastCard.swift
//  WeatherApp
//
//  Created by Valentyna Kharkova on 15.02.2026.
//

import SwiftUI

struct HourlyForecastCard: View {
    
    @ObservedObject private var tempSettings = TemperatureSettings.shared
    
    let item: ForecastItem
    
    var body: some View {
        VStack(spacing: 12) {
            Text(timeString)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundStyle(.white.opacity(0.8))
            
            Image(systemName: weatherIcon)
                .font(.system(size: 28))
                .foregroundStyle(.white)
                .frame(height: 28)
            
            Text(tempSettings.format(item.main.temp))
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
        }
        .frame(width: 70)
        .padding(.vertical, 16)
        .background(.white.opacity(0.15))
        .cornerRadius(20)
    }
    
    //MARK: Time String
    private var timeString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: item.date)
    }
    //MARK: Weather Icon
    private var weatherIcon: String {
        guard let main = item.weather.first?.main else { return "cloud.fill" }
        
        switch main.lowercased() {
            case "clear":
            return "sun.max.fill"
        case "clouds":
            return "cloud.fill"
        case "rain":
            return "cloud.rain.fill"
        case "drizzle":
            return "cloud.drizzle.fill"
        case "thunderstorm":
            return "cloud.bolt.fill"
        case "snow":
            return "cloud.snow.fill"
        case "mist", "fog":
            return "cloud.fog.fill"
        default:
            return "cloud.fill"
        }
    }
}

#Preview {
    ZStack {
        BackgroundGradient()
        HourlyForecastCard(item: ForecastData.mock.list[0])
    }
}
