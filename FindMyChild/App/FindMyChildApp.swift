//
//  FindMyChildApp.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 12/06/2024.
//

import SwiftUI

@main
struct FindMyChildApp: App {
    let mapStateManager = MapStateManager()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(mapStateManager)
        }
    }
}
