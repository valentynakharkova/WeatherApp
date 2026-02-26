//
//  Modifiers.swift
//  WeatherApp
//
//  Created by Valentyna Kharkova on 24.02.2026.
//

import SwiftUI

struct Modifiers: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.white.opacity(0.5))
    }
}

extension View {
    func colorModifier() -> some View {
        modifier(Modifiers())
    }
}
