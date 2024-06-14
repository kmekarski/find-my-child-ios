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
            Text(typeSignUpString)
            Button(action: goBack, label: {
                Text("back_string")
            })
            Button(action: goToSignIn, label: {
                Text("go_to_sign_in_string")
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
    var typeSignUpString: String {
        switch type {
        case .parent:
            return String(localized: "parent_sign_up_string")
        case .child:
            return String(localized: "child_sign_up_string")
        }
    }
    func goBack() {
        navVM.pop()
    }
    
    func goToSignIn() {
        navVM.popToRoot()
    }
}
