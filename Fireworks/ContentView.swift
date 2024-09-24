//
//  ContentView.swift
//  Fireworks
//
//  Created by Péter Sebestyén on 2024.09.24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var particleSystem = ParticleSystem()
    var body: some View {
        EmitterView(particleSystem: particleSystem)
            .ignoresSafeArea()
            .background(.black)
    }
}

#Preview {
    ContentView()
}
