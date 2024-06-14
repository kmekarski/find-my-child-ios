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
        ZStack {
            if signedIn {
                HomeView()
                    .transition(.move(edge: .trailing))
            } else {
                AuthView()
                    .transition(.move(edge: .leading))
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
        .environmentObject(authManager)
        .environmentObject(MapViewModel())
        .environmentObject(HomeViewModel(childrenManager: MockChildrenManager()))
        .environmentObject(AuthNavigationViewModel())
        .environmentObject(SignInViewModel(authManager: authManager))
        .environmentObject(SignUpViewModel(authManager: authManager))
}
