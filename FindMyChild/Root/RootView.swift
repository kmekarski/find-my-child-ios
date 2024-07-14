//
//  RootView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 13/06/2024.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var authVM: AuthViewModel
    var body: some View {
        ZStack {
            if signedIn {
                HomeNavigationView()
                    .transition(.move(edge: .trailing))
            } else {
                AuthNavigationView()
                    .transition(.move(edge: .leading))
            }
        }
    }
}

private extension RootView {
    var signedIn: Bool {
        return authVM.isSignedIn
    }
}

#Preview {
    let authManager = MockAuthManager()
    return RootView()
        .environmentObject(MapViewModel())
        .environmentObject(HomeViewModel(childrenManager: MockChildrenManager()))
        .environmentObject(AuthNavigationViewModel())
        .environmentObject(HomeNavigationViewModel())
        .environmentObject(SignInViewModel(authManager: authManager))
        .environmentObject(SignUpViewModel(authManager: authManager))
        .environmentObject(AuthViewModel(authManager: authManager))
}
