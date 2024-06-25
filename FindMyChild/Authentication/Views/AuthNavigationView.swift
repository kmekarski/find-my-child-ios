//
//  AuthView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 13/06/2024.
//

import SwiftUI

struct AuthViewSettings {
    static let bottomPadding: CGFloat = 32
    static let topPadding: CGFloat = 48
    static let headerTitleFontSize: CGFloat = 28
    static let headerSubitleFontSize: CGFloat = 18
    static let headerBottomPadding: CGFloat = 32
    static let headerHorizontalPadding: CGFloat = 32
    static let headerTitleBottomPadding: CGFloat = 8
    static let authButtonBottomPadding: CGFloat = 12
    static let authButtonTopPadding: CGFloat = 8
}

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
