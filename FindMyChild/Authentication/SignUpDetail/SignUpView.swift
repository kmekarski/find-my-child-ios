//
//  SignUpDetailView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 14/06/2024.
//

import SwiftUI

enum UserType: String {
    case parent
    case child
}

struct SignUpView: View {
    @EnvironmentObject var navVM: AuthNavigationViewModel
    var type: UserType
    var body: some View {
        VStack {
            Text("sign up " + type.rawValue)
            Button(action: goBack, label: {
                Text("Back")
            })
            Button(action: goToSignIn, label: {
                Text("go_to_sign_in")
            })
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    SignUpView(type: .parent)
        .environmentObject(AuthNavigationViewModel())
}

private extension SignUpView {
    func goBack() {
        navVM.pop()
    }
    
    func goToSignIn() {
        navVM.popToRoot()
    }
}
