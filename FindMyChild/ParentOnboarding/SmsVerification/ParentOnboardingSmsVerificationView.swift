//
//  ParentOnboardingSmsVerificationView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 26/07/2024.
//

import SwiftUI

struct ParentOnboardingSmsVerificationView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @EnvironmentObject var vm: ParentOnboardingViewModel
    @State var verificationText: String = ""
    var body: some View {
        VStack {
            if let user = authVM.currentUser {
                Text("Account verification")
                    .customFont(.regular, 32)
                    .padding(.bottom, 12)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Group {
                    Text("Enter a 4-digit verification code sent to ")
                        .customFont(.regular, 18)
                        .foregroundStyle(.second) +
                    Text(user.phoneNumber)
                        .customFont(.regular, 18)
                        .foregroundStyle(.prim) +
                    Text(".")
                        .customFont(.regular, 18)
                        .foregroundStyle(.second)
                }
                .padding(.bottom, 40)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                OTPTextFieldView(text: $verificationText)
                    .padding(.bottom)
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Resend code")
                })
                Spacer()
                Button(action: submit, label: {
                    WideButtonView("Continue")
                })
            }
        }
    }
}

#Preview {
    let userManager = MockUserManager()
    let authManager = MockAuthManager()
    return ParentOnboardingSmsVerificationView()
        .padding()
        .environmentObject(AuthViewModel(authManager: authManager))
        .environmentObject(ParentOnboardingViewModel(userManager: userManager, authManager: authManager))
}

private extension ParentOnboardingSmsVerificationView {
    func submit() {
        if verificationText.count == 4 {
            vm.goToNextStep()
        }
    }
}
