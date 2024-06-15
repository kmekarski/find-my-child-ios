//
//  SignUpView().swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 13/06/2024.
//

import SwiftUI

enum UserType {
    case parent
    case child
    
    var text: String {
        switch self {
        case .parent:
            return String(localized: "parent_string")
        case .child:
            return String(localized: "child_string")
        }
    }
}

struct SignUpView: View {
    @EnvironmentObject var signUpVM: SignUpViewModel
    @EnvironmentObject var navVM: AuthNavigationViewModel
    var body: some View {
        VStack {
            
            if signUpVM.selectedAccountType == nil {
                chooseSignUpMessage
            }
            
            accountTypeButtons
            
            form
                .padding(.vertical, 24)
            
            signUpButton
            
            goToSignInButton
        }
        .padding()
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    SignUpView()
        .environmentObject(SignUpViewModel(authManager: AuthManager()))
        .environmentObject(AuthNavigationViewModel())
}

private extension SignUpView {
    
    func chooseSignUp(type: UserType) {
        signUpVM.selectedAccountType = type
    }
    
    func signUp() {
        signUpVM.signUp()
    }
    
    func goToSignIn() {
        navVM.pop()
    }
    
    func chooseSignUpButton(type: UserType) -> some View {
        let isSelected = type == signUpVM.selectedAccountType
        return Button(action: { chooseSignUp(type: type) }, label: {
            VStack {
                Text(type.text)
                    .customFont(.regular, 24)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 64)
            .foregroundStyle(isSelected ? .accent : .second)
            .background(isSelected ? .primaryContainer : .secondaryContainer)
            .clipShape(.rect(cornerRadius: 16))
        })
    }
    
    var chooseSignUpMessage: some View {
        Text("choose_sign_up_string")
            .customFont(.regular, 24)
            .padding(.bottom)
    }
    
    var accountTypeButtons: some View {
        HStack(spacing: 12) {
            chooseSignUpButton(type: .child)
            chooseSignUpButton(type: .parent)
        }
    }
    
    var form: some View {
        VStack {
            ForEach(SignUpTextField.allCases, id: \.self) { field in
                AuthTextFieldView(title: field.text, text: signUpVM.binding(for: field), clearButtonVisible: true)
            }
        }
    }
    
    var signUpButton: some View {
        let text = String(localized: "sign_up_string")
        return Button(action: signUp, label: {
            WideButtonView(text)
        })
    }
    
    var goToSignInButton: some View {
        Button(action: goToSignIn, label: {
            Text("go_to_sign_in_string")
        })
    }

}

