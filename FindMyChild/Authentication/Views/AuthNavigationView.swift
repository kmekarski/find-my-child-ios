//
//  AuthView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 13/06/2024.
//

import SwiftUI

struct AuthNavigationView: View {
    @EnvironmentObject var navVM: AuthNavigationViewModel
    var body: some View {
        NavigationStack(path: $navVM.path) {
            AuthenticationView(screenType: .signIn)
                .navigationDestination(for: AuthScreenType.self) { screenType in
                    AuthenticationView(screenType: screenType)
                }
        }
    }
}

#Preview {
    let authManager = MockAuthManager()
    return AuthNavigationView()
        .environmentObject(AuthNavigationViewModel())
        .environmentObject(AuthViewModel(authManager: authManager))
        .environmentObject(SignInViewModel(authManager: authManager))
        .environmentObject(SignUpViewModel(authManager: authManager))
}


struct AuthFormTitleView: View {
    var text: String
    var body: some View {
        Text(text)
            .foregroundStyle(.prim)
            .customFont(.regular, 20)
            .padding(.bottom, 12)
    }
}
