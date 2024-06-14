//
//  AuthView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 13/06/2024.
//

import SwiftUI

struct AuthView: View {
    @EnvironmentObject var navVM: AuthNavigationViewModel
    var body: some View {
        NavigationStack(path: $navVM.path) {
            SignInView()
                .navigationDestination(for: AuthRoute.self) { routes in
                    switch routes {
                    case .signIn:
                        SignInView()
                    case .chooseSignUp:
                        ChooseSignUpView()
                    case .signUpParent:
                        SignUpView(type: .parent)
                    case .signUpChild:
                        SignUpView(type: .child)
                    }
                }
        }
    }
}

#Preview {
    AuthView()
        .environmentObject(AuthNavigationViewModel())
}
