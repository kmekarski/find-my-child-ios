//
//  RootView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 13/06/2024.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var authManager: AuthManager
    var body: some View {
        VStack {
            if signedIn {
                HomeView()
            } else {
                AuthView()
            }
        }
    }
}

private extension RootView {
    var signedIn: Bool {
        return authManager.signedIn
    }
}

#Preview {
    let authManager: AuthManager = AuthManager()
    return RootView()
        .environmentObject(MapStateManager())
        .environmentObject(authManager)
        .environmentObject(AuthNavigationViewModel())
        .environmentObject(SignInViewModel(authManager: authManager))
        .environmentObject(SignUpViewModel(authManager: authManager))
}
