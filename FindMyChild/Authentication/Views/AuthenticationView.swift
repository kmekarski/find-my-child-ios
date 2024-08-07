//
//  AuthenticationView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 25/06/2024.
//

import SwiftUI

private extension AppRoute {
    var showBackButton: Bool {
        switch self {
        case .signUp, .chooseUserType: true
        default: false
        }
    }
}

struct AuthenticationView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @EnvironmentObject var signUpVM: SignUpViewModel
    @EnvironmentObject var signInVM: SignInViewModel
    @EnvironmentObject var navVM: NavigationViewModel
    var screenType: AppRoute
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                header
            }
            .padding(32)
            .background(.prim)
            
            ScrollView {
                VStack {
                    switch screenType {
                    case .signIn:
                        signInForm
                    case .signUp:
                        signUpform
                    case .chooseUserType:
                        chooseAccountTypeButtons
                            .padding(.bottom, 24)
                        chooseAccountTypeInfo
                    default: EmptyView()
                    }
                }
                .padding(.top)
                .padding(.horizontal)
            }
            VStack {
                    authButton
                        .padding(.bottom, 12)
                switchScreenButton
            }
            .padding(.top, 8)
            .padding(.horizontal)
            .padding(.bottom, 32)
        }
        .navigationBarBackButtonHidden()
        .toastView(toast: $authVM.toast)
        .toastView(toast: $signInVM.toast)
        .toastView(toast: $signUpVM.toast)
    }
}

#Preview {
    let authManager = MockAuthManager()
    return AuthenticationView(screenType: .signIn)
        .environmentObject(NavigationViewModel(authManager: authManager))
        .environmentObject(SignInViewModel(authManager: authManager))
        .environmentObject(SignUpViewModel(authManager: authManager))
        .environmentObject(AuthViewModel(authManager: authManager))
}

private extension AuthenticationView {
    func signIn() async {
        await signInVM.signIn()
    }
    
    func signUp() async {
        await signUpVM.signUp()
    }
    
    func goToSignUp() {
        navVM.navigate(route: .signUp)
    }
    
    func goToSignIn() {
        navVM.popToRoot()
    }
    
    func goToChooseUserType() {
        navVM.navigate(route: .chooseUserType)
    }
    
    func goBack() {
        navVM.pop()
    }
    
    func onAuthButtonTapped() {
        Task {
            switch screenType {
            case .signIn:
                await signIn()
            case .signUp:
                await signUp()
            case .chooseUserType:
                goToSignUp()
            default: break
            }
        }
    }
    
    func onSwitchScreenButtonTapped() {
        switch screenType {
        case .signIn:
            goToChooseUserType()
        case .signUp:
            goToSignIn()
        case .chooseUserType:
            goToSignIn()
        default: break
        }
    }
    
    func onChooseUserType(type: UserType) {
        signUpVM.selectedAccountType = type
    }
    
    var headerTitleText: String {
        switch screenType {
        case .signIn: String(localized: "sign_in_title_string")
        case .signUp: String(localized: "sign_up_title_string")
        case .chooseUserType: String(localized: "choose_account_type_string")
        default: ""
        }
    }
    
    var headerSubtitleText: String? {
        switch screenType {
        case .signIn: String(localized: "sign_in_subtitle_string")
        default: nil
        }
    }
    
    var formTitleText: String {
        if screenType == .signIn {
            return String(localized: "sign_in_data_string")
        } else if screenType == .signUp {
            return switch signUpVM.selectedAccountType {
            case .child: String(localized: "child_data_string")
            case .parent: String(localized: "parent_data_string")
            case .none: ""
            }
        }
        return ""
    }
    
    var authButtonText: String {
        switch screenType {
        case .signIn: String(localized: "sign_in_string")
        case .signUp: String(localized: "sign_up_string")
        case .chooseUserType: String(localized: "go_next_string")
        default: ""
        }
    }
    
    var switchScreenButtonText: String {
        switch screenType {
        case .signIn: String(localized: "go_to_sign_up_string")
        case .signUp: String(localized: "go_to_sign_in_string")
        case .chooseUserType: String(localized: "go_to_sign_in_string")
        default: ""
        }
    }
    
    var header: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: 12) {
                if screenType.showBackButton {
                    backButton
                }
                Text(headerTitleText)
                    .foregroundStyle(.onPrimary)
                    .customFont(.regular, 28)
            }
                .padding(.bottom, 8)
            if let headerSubtitleText = headerSubtitleText {
                Text(headerSubtitleText)
                    .foregroundStyle(.primaryContainer)
                    .customFont(.regular, 18)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var backButton: some View {
        Button(action: goBack, label: {
            IconButtonView(icon: "chevron.left", size: .small)
        })
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
            UserTypeButtonView(type: .parent, isSelected: signUpVM.selectedAccountType == .parent, action: onChooseUserType)
            UserTypeButtonView(type: .child, isSelected: signUpVM.selectedAccountType == .child, action: onChooseUserType)
        }
    }
    
    var chooseAccountTypeInfo: some View {
        let headerText: String = switch signUpVM.selectedAccountType {
        case .parent: String(localized: "choose_account_type_info_header_parent_string")
        case .child: String(localized: "choose_account_type_info_header_child_string")
        case .none: ""
        }
        let infoList: [String] = switch signUpVM.selectedAccountType {
        case .parent: [
            String(localized: "choose_account_type_info_row_parent_1_string"),
            String(localized: "choose_account_type_info_row_parent_2_string"),
            String(localized: "choose_account_type_info_row_parent_3_string"),
            String(localized: "choose_account_type_info_row_parent_4_string"),
        ]
        case .child: [
            String(localized: "choose_account_type_info_row_child_1_string"),
            String(localized: "choose_account_type_info_row_child_2_string"),
            String(localized: "choose_account_type_info_row_child_3_string"),
            String(localized: "choose_account_type_info_row_child_4_string"),
        ]
        case .none: []
        }
        return VStack {
            Text(headerText)
                .customFont(.regular, 20)
                .multilineTextAlignment(.center)
            Divider()
            VStack(alignment: .leading) {
                ForEach(infoList, id: \.self) { rowText in
                    HStack(alignment: .top) {
                        Image(systemName: "checkmark.circle")
                            .foregroundStyle(.check)
                            .fontWeight(.semibold)
                        Text(rowText)
                    }
                    .padding(.vertical, 6)
                    Divider()
                }
            }
        }
        .padding(.horizontal, 8)
    }
    
    var authButton: some View {
        return Button(action: onAuthButtonTapped, label: {
            WideButtonView(authButtonText, isLoading: authVM.isAuthenticating)
        })
    }
    
    var switchScreenButton: some View {
        Button(action: onSwitchScreenButtonTapped, label: {
            Text(switchScreenButtonText)
                .customFont(.regular)
                .foregroundStyle(.accent)
        })
    }
    
}
