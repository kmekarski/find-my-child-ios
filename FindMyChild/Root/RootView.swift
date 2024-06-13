//
//  RootView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 13/06/2024.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var rootVM: RootViewModel
    var body: some View {
        Text(rootVM.signedIn.description)
    }
}

#Preview {
    RootView()
        .environmentObject(RootViewModel(authManager: AuthManager()))
}
