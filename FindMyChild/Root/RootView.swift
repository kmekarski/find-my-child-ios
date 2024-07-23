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
            RootRouter.getRoute(currentUser: authVM.currentUser, isSignedIn: isSignedIn).transition(.move(edge: .leading))
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
        .environmentObject(AuthNavigationViewModel())
        .environmentObject(HomeNavigationViewModel())
        .environmentObject(SignInViewModel(authManager: authManager))
        .environmentObject(SignUpViewModel(authManager: authManager))
        .environmentObject(AuthViewModel(authManager: authManager))
}

class RootRouter {
    static func getRoute(currentUser: User?, isSignedIn: Bool) -> some View {
        var resultView: any View = AuthNavigationView()

        guard let currentUser = currentUser, isSignedIn else {
            return AnyView(AuthNavigationView())
        }
        
        if currentUser.type == .parent && currentUser.isFirstLogin {
            resultView = ParentOnboardingView()
        } else {
            resultView = HomeNavigationView()
        }
        
        return AnyView(resultView)
    }
}
