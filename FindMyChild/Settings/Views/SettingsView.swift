//
//  SettingsView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 14/07/2024.
//

import SwiftUI

struct SettingsView: HomeScreenProtocol {
    var type: HomeScreenType = .settings
    var body: some View {
        Text("Settings")
    }
}

#Preview {
    SettingsView()
}
