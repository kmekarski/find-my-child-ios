//
//  FindMyChildApp.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 12/06/2024.
//

import SwiftUI
import FirebaseCore

@main
struct FindMyChildApp: App {
    var childrenManager: ChildrenManagerProtocol
    var authManager: AuthManagerProtocol
    var userManager: UserManager
    var authVM: AuthViewModel
    var authNavVM: AuthNavigationViewModel
    var signInVM: SignInViewModel
    var signUpVM: SignUpViewModel
    var homeVM: HomeViewModel
    var homeNavVM: HomeNavigationViewModel
    var mapVM: MapViewModel
    var parentOnboardingVM: ParentOnboardingViewModel
    
    init() {
        FirebaseApp.configure()
        childrenManager = ChildrenManager()
        authManager = AuthManager()
        userManager = UserManager()
        authVM = AuthViewModel(authManager: authManager)
        authNavVM = AuthNavigationViewModel()
        signInVM = SignInViewModel(authManager: authManager)
        signUpVM = SignUpViewModel(authManager: authManager)
        homeVM = HomeViewModel(childrenManager: childrenManager)
        homeNavVM = HomeNavigationViewModel()
        mapVM = MapViewModel()
        parentOnboardingVM = ParentOnboardingViewModel(userManager: userManager, authManager: authManager)
    }
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(authVM)
                .environmentObject(authNavVM)
                .environmentObject(signInVM)
                .environmentObject(signUpVM)
                .environmentObject(homeVM)
                .environmentObject(homeNavVM)
                .environmentObject(mapVM)
                .environmentObject(parentOnboardingVM)
        }
    }
}
