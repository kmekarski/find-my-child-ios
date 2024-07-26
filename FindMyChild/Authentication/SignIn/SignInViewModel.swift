//
//  SignInViewModel.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 13/06/2024.
//

import Foundation
import SwiftUI

class SignInViewModel: ObservableObject {
    var authManager: AuthManagerProtocol
    
    @Published var textParams: SignInTextParams = SignInTextParams()
    @Published var toast: Toast?
    
    init(authManager: AuthManagerProtocol) {
        self.authManager = authManager
    }
    
    func signIn() async {
        let email = textParams.email
        let password = textParams.password
        let validationResult = authManager.validateSignIn(email: email, password: password)
        switch validationResult {
        case .success(_):
            await authManager.signIn(email: email, password: password)
        case .failure(let error):
            showErrorToast(error: error)
        }
    }
    
    private func showErrorToast(error: any AuthErrorProtocol) {
        toast = Toast(style: .error, message: error.message)
    }
}
