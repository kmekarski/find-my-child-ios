//
//  ContentView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 12/06/2024.
//

import SwiftUI
import MapKit

struct ContentView: View {
    var body: some View {
        ZStack {
            MapViewRepresentable()
                .ignoresSafeArea()
            VStack {
                Spacer()
                VStack {
                    
                }
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .background()
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(MapStateManager())
}
