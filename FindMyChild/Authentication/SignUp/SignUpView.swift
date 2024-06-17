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
    
    var icon: String {
        switch self {
        case .parent:
            return "figure.and.child.holdinghands"
        case .child:
            return "figure.child"
        }
    }
}

struct SignUpView: View {
    @EnvironmentObject var signUpVM: SignUpViewModel
    @EnvironmentObject var navVM: AuthNavigationViewModel
    var body: some View {
        VStack {
            
            VStack {
                chooseSignUpMessage
                accountTypeButtons
            }
            .padding(32)
            .padding(.top, 32)
            .background(.prim)
            
            VStack {
                form
                    .padding(.vertical, 24)
                
                signUpButton
                    .padding(.bottom, 12)
                
                goToSignInButton
                
            }
            .padding()
            Spacer()
        }
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
        withAnimation {
            signUpVM.selectedAccountType = type
        }
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
                Image(systemName: type.icon)
                    .font(.system(size: isSelected ? 36 : 30))
                Text(type.text)
                    .customFont(.regular, isSelected ? 20 : 18)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundStyle(isSelected ? .accent : .second)
            .background(isSelected ? .primaryContainer : .surface)
            .clipShape(.rect(cornerRadius: 16))
            .customShadow(.outline)
        })
    }
    
    var chooseSignUpMessage: some View {
        Text("choose_sign_up_string")
            .foregroundStyle(.onPrimary)
            .customFont(.regular, 24)
            .padding(.bottom)
    }
    
    var accountTypeButtons: some View {
        HStack(spacing: 12) {
            chooseSignUpButton(type: .parent)
            chooseSignUpButton(type: .child)
        }
        .frame(height: 108)
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

