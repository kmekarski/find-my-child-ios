//
//  SignInView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 13/06/2024.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject var signInVM: SignInViewModel
    @EnvironmentObject var navVM: AuthNavigationViewModel
    var body: some View {
        VStack {
            Button(action: signIn, label: {
                Text("Sign in")
            })
            Button(action: goToSignUp, label: {
                Text("go_to_sign_up")
            })
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    SignInView()
        .environmentObject(SignInViewModel(authManager: AuthManager()))
        .environmentObject(AuthNavigationViewModel())
}

private extension SignInView {
    func signIn() {
        signInVM.signIn()
    }
    
    func goToSignUp() {
        navVM.navigate(route: .chooseSignUp)
    }
}
