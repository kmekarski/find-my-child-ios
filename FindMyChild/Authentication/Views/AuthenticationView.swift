//
//  AuthenticationView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 25/06/2024.
//

import SwiftUI


struct AuthenticationView: View {
    @EnvironmentObject var signUpVM: SignUpViewModel
    @EnvironmentObject var signInVM: SignInViewModel
    @EnvironmentObject var navVM: AuthNavigationViewModel
    
    @State var currentScreen: AuthRoute = .signIn
    var body: some View {
        VStack {
            VStack {
                header
            }
            .padding(.horizontal, AuthViewSettings.headerHorizontalPadding)
            .padding(.top, AuthViewSettings.topPadding)
            .padding(.bottom, AuthViewSettings.headerBottomPadding)
            .background(.prim)
            
            ScrollView {
                VStack {
                    switch currentScreen {
                    case .signIn:
                        signInForm
                    case .signUp:
                        signUpform
                    case .chooseUserType:
                        chooseAccountTypeButtons
                    }
                }
                .padding(.top)
                .padding(.horizontal)
            }
            VStack {
                authButton
                    .padding(.bottom, AuthViewSettings.authButtonBottomPadding)
                switchScreenButton
            }
            .padding(.top, AuthViewSettings.authButtonTopPadding)
            .padding(.horizontal)
            .padding(.bottom, AuthViewSettings.bottomPadding)
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    let authManager = AuthManager()
    return AuthenticationView()
        .environmentObject(AuthNavigationViewModel())
        .environmentObject(SignInViewModel(authManager: authManager))
        .environmentObject(SignUpViewModel(authManager: authManager))
}

private extension AuthenticationView {
    func signIn() {
        withAnimation {
            signInVM.signIn()
        }
    }
    
    func signUp() {

    }
    
    
    func goToSignUp() {
        navVM.navigate(route: .signUp)
    }
    
    func goToSignIn() {
        navVM.navigate(route: .signIn)
    }
    
    func onAuthButtonTapped() {
        switch currentScreen {
        case .signIn:
            goToSignUp()
        case .signUp:
            goToSignIn()
        case .chooseUserType:
            break
        }
    }
    
    func onChooseUserType(type: UserType) {
        withAnimation {
            signUpVM.selectedAccountType = type
        }
    }
    
    var headerTitleText: String {
        switch currentScreen {
        case .signIn: String(localized: "sign_in_title_string")
        case .signUp: String(localized: "sign_up_title_string")
        case .chooseUserType: String(localized: "choose_account_type_string")
        }
    }
    
    var headerSubtitleText: String? {
        switch currentScreen {
        case .signIn: String(localized: "sign_in_subtitle_string")
        case .signUp: nil
        case .chooseUserType: nil
        }
    }
    
    var formTitleText: String {
        if currentScreen == .signIn {
            return String(localized: "sign_in_data_string")
        } else if currentScreen == .signUp {
            let text = switch signUpVM.selectedAccountType {
            case .child: String(localized: "child_data_string")
            case .parent: String(localized: "parent_data_string")
            case .none: ""
            }
        } else { return "" }
    }
    
    var authButtonText: String {
        switch currentScreen {
        case .signIn: String(localized: "sign_in_string")
        case .signUp: String(localized: "sign_up_string")
        case .chooseUserType: ""
        }
    }
    
    var switchScreenButtonText: String {
        switch currentScreen {
        case .signIn: String(localized: "go_to_sign_up_string")
        case .signUp: String(localized: "go_to_sign_in_string")
        case .chooseUserType: ""
        }
    }
    
    var header: some View {
        VStack(alignment: .leading) {
            Text(headerTitleText)
                .foregroundStyle(.onPrimary)
                .customFont(.regular, AuthViewSettings.headerTitleFontSize)
                .padding(.bottom, AuthViewSettings.headerTitleBottomPadding)
            if let headerSubtitleText = headerSubtitleText {
                Text(headerSubtitleText)
                    .foregroundStyle(.primaryContainer)
                    .customFont(.regular, AuthViewSettings.headerSubitleFontSize)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var signInForm: some View {
        VStack(alignment: .leading) {
            AuthFormTitleView(text: formTitleText)
            AuthTextFieldView(title: SignInTextParams.emailHint, text: $signInVM.textParams.email)
            AuthTextFieldView(title: SignInTextParams.passwordHint, text: $signInVM.textParams.password, type: .password)
        }
    }
    
    var signUpform: some View {
        VStack(alignment: .leading) {
            AuthFormTitleView(text: formTitleText)
            AuthTextFieldView(title: SignUpTextParams.nameHint, text: $signUpVM.textParams.name)
            AuthTextFieldView(title: SignUpTextParams.emailHint, text: $signUpVM.textParams.email)
            AuthTextFieldView(title: SignUpTextParams.passwordHint, text: $signUpVM.textParams.password, type: .password)
            AuthTextFieldView(title: SignUpTextParams.repeatPasswordHint, text: $signUpVM.textParams.repeatPassword, type: .password)
            AuthTextFieldView(title: SignUpTextParams.phoneNumberHint, text: $signUpVM.textParams.phoneNumber)
        }
    }
    
    var chooseAccountTypeButtons: some View {
        HStack(spacing: 12) {
            UserTypeButtonView(type: .parent, action: onChooseUserType)
            UserTypeButtonView(type: .child, action: onChooseUserType)
        }
    }
    
    var authButton: some View {
        return Button(action: onAuthButtonTapped, label: {
            WideButtonView(authButtonText)
        })
    }
    
    var switchScreenButton: some View {
        Button(action: goToSignIn, label: {
            Text(switchScreenButtonText)
                .customFont(.regular)
                .foregroundStyle(.accent)
        })
    }
}
