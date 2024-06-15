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
                Text("sign_in_string")
            })
            Button(action: goToSignUp, label: {
                Text("go_to_sign_up_string")
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
        withAnimation {
            signInVM.signIn()
        }
    }
    
    func goToSignUp() {
        navVM.navigate(route: .signUp)
    }
}
