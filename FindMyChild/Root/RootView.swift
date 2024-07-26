//
//  RootView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 13/06/2024.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @EnvironmentObject var navVM: NavigationViewModel
    var body: some View {
        NavigationStack(path: $navVM.path) {
            AuthenticationView(screenType: .signIn)
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case .signIn, .signUp, .chooseUserType: AuthenticationView(screenType: route)
                    case .map: HomeTemplateView(screen: HomeView(), header: MapHeaderView())
                    case .settings: HomeTemplateView(screen: SettingsView(), header: SettingsHeaderView())
                    case .profile: HomeTemplateView(screen: ProfileView(), header: ProfileHeaderView())
                    case .parentOnboarding: ParentOnboardingView()
                    }
                }
        }
    }
}

private extension RootView {
    var isSignedIn: Bool {
        return authVM.isSignedIn
    }
}

#Preview {
    let authManager = MockAuthManager()
    return RootView()
        .environmentObject(MapViewModel())
        .environmentObject(HomeViewModel(childrenManager: MockChildrenManager()))
        .environmentObject(NavigationViewModel(authManager: authManager))
        .environmentObject(SignInViewModel(authManager: authManager))
        .environmentObject(SignUpViewModel(authManager: authManager))
        .environmentObject(AuthViewModel(authManager: authManager))
}
