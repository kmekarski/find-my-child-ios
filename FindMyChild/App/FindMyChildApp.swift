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
    var navVM: NavigationViewModel
    var authVM: AuthViewModel
    var signInVM: SignInViewModel
    var signUpVM: SignUpViewModel
    var homeVM: HomeViewModel
    var mapVM: MapViewModel
    var parentOnboardingVM: ParentOnboardingViewModel
    
    init() {
        FirebaseApp.configure()
        childrenManager = ChildrenManager()
        authManager = AuthManager()
        userManager = UserManager()
        navVM = NavigationViewModel(authManager: authManager)
        authVM = AuthViewModel(authManager: authManager)
        signInVM = SignInViewModel(authManager: authManager)
        signUpVM = SignUpViewModel(authManager: authManager)
        homeVM = HomeViewModel(childrenManager: childrenManager)
        mapVM = MapViewModel()
        parentOnboardingVM = ParentOnboardingViewModel(userManager: userManager, authManager: authManager)
    }
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(navVM)
                .environmentObject(authVM)
                .environmentObject(signInVM)
                .environmentObject(signUpVM)
                .environmentObject(homeVM)
                .environmentObject(mapVM)
                .environmentObject(parentOnboardingVM)
        }
    }
}
