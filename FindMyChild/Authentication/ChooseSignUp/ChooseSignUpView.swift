//
//  SignUpView().swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 13/06/2024.
//

import SwiftUI

struct ChooseSignUpView: View {
    @EnvironmentObject var signUpVM: SignUpViewModel
    @EnvironmentObject var navVM: AuthNavigationViewModel
    var body: some View {
        VStack {
            Button(action: {
                chooseSignUp(type: .parent)
            }, label: {
                Text("parent_string")
            })

            Button(action: {
                chooseSignUp(type: .child)
            }, label: {
                Text("child_string")
            })
            Button(action: goToSignIn, label: {
                Text("go_to_sign_in_string")
            })
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ChooseSignUpView()
        .environmentObject(SignUpViewModel(authManager: AuthManager()))
        .environmentObject(AuthNavigationViewModel())
}

private extension ChooseSignUpView {
    func chooseSignUp(type: UserType) {
        switch type {
        case .parent:
            navVM.navigate(route: .signUpParent)
        case .child:
            navVM.navigate(route: .signUpChild)
        }
    }
    
    func goToSignIn() {
        navVM.pop()
    }
}
