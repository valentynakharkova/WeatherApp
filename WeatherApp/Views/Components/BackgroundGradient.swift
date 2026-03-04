//
//  BackgroundGradient.swift
//  WeatherApp
//
//  Created by Valentyna Kharkova on 15.02.2026.
//
import SwiftUI

struct BackgroundGradient: View {
    
    var weather: WeatherData? = nil
    
    var body: some View {
            // background
            LinearGradient(
                colors: gradientColors,
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
    }
    
    enum GradientType {
        case day
        case cloudy
        case night
    }
    
    private func timeBasedGradient() -> GradientType {
        let hour = Calendar.current.component(.hour, from: Date())
        
        if hour < 6 || hour >= 20 {
            return .night
        } else {
            return .day
        }
    }
    
    private var gradientType: GradientType {
        guard let weather = weather else {
            return timeBasedGradient()
        }
        // For Testing
        let now = Date(timeIntervalSince1970: TimeInterval(weather.dt))
        //For Production
        let sunriseDate = Date(timeIntervalSince1970: TimeInterval(weather.sys.sunrise))
        let sunsetDate = Date(timeIntervalSince1970: TimeInterval(weather.sys.sunset))
        
        // Night starts 1 hour after sunset
        let nightStartTime = sunsetDate.addingTimeInterval(3600) // 3600 sec = 1 hour
        // Day starts 1 hour after sunrise
        let nightEndTime = sunriseDate.addingTimeInterval(-3600)
        
        if now > nightStartTime || now < nightEndTime {
            return .night
        }
        
        if weather.clouds.all > 50 {
            return .cloudy
        }
        
        return .day
    }
    
    private var gradientColors: [Color] {
        switch gradientType {
        case .day:
            return [
                Color("DayGradientStart"),
                Color("DayGradientEnd")
            ]
        case .cloudy:
            return [
                Color("CloudyGradientStart"),
                Color("CloudyGradientEnd")
            ]
        case .night:
            return [
                Color("NightGradientStart"),
                Color("NightGradientEnd")
            ]
        }
    }
    
    
}

#Preview("Day") {
    ZStack {
        LinearGradient(
            colors: [
                Color("DayGradientStart"),
                Color("DayGradientEnd")
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
        
        Text("DAY - Should be Light Blue")
            .font(.title)
            .foregroundStyle(.white)
    }
}

#Preview("Cloudy") {
    ZStack {
        LinearGradient(
            colors: [
                Color("CloudyGradientStart"),
                Color("CloudyGradientEnd")
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
        
        Text("CLOUDY - Should be Gray")
            .font(.title)
            .foregroundStyle(.white)
    }
}

#Preview("Night") {
    ZStack {
        LinearGradient(
            colors: [
                Color("NightGradientStart"),
                Color("NightGradientEnd")
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
        
        Text("NIGHT - Should be Dark Blue")
            .font(.title)
            .foregroundStyle(.white)
    }
}
