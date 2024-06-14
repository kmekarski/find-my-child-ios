//
//  FindMyChildApp.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 12/06/2024.
//

import SwiftUI

@main
struct FindMyChildApp: App {
    var mapStateManager: MapStateManager
    var authManager: AuthManager
    var signInVM: SignInViewModel
    var signUpVM: SignUpViewModel
    
    var authNavVM: AuthNavigationViewModel
    init() {
        mapStateManager = MapStateManager()
        authManager = AuthManager()
        signInVM = SignInViewModel(authManager: authManager)
        signUpVM = SignUpViewModel(authManager: authManager)
        
        authNavVM = AuthNavigationViewModel()
    }
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(mapStateManager)
                .environmentObject(authManager)
                .environmentObject(signInVM)
                .environmentObject(signUpVM)
                .environmentObject(authNavVM)
        }
    }
}
