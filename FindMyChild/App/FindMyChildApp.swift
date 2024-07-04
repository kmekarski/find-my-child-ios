//
//  FindMyChildApp.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 12/06/2024.
//

import SwiftUI

@main
struct FindMyChildApp: App {
    var childrenManager: ChildrenManagerProtocol
    var authManager: AuthManagerProtocol
    var authVM: AuthViewModel
    var signInVM: SignInViewModel
    var signUpVM: SignUpViewModel
    var homeVM: HomeViewModel
    var mapVM: MapViewModel
    var authNavVM: AuthNavigationViewModel
    init() {
        childrenManager = ChildrenManager()
        authManager = AuthManager()
        authVM = AuthViewModel(authManager: authManager)
        authNavVM = AuthNavigationViewModel()
        signInVM = SignInViewModel(authManager: authManager)
        signUpVM = SignUpViewModel(authManager: authManager)
        homeVM = HomeViewModel(childrenManager: childrenManager)
        mapVM = MapViewModel()
        
        for family in UIFont.familyNames {
            print("Family: \(family)")
            for name in UIFont.fontNames(forFamilyName: family) {
                print("   - \(name)")
            }
        }
    }
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(authVM)
                .environmentObject(signInVM)
                .environmentObject(signUpVM)
                .environmentObject(homeVM)
                .environmentObject(mapVM)
                .environmentObject(authNavVM)
        }
    }
}
