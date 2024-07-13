//
//  SignInViewModel.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 13/06/2024.
//

import Foundation
import SwiftUI

class SignInViewModel: ObservableObject {
    var delegate: SignInViewModelDelegate?
    var authManager: AuthManagerProtocol
    
    @Published var textParams: SignInTextParams = SignInTextParams()
    
    init(authManager: AuthManagerProtocol) {
        self.authManager = authManager
    }
    
    func signIn() {
        print(textParams.email)
        print(textParams.password)
        let email = textParams.email
        let password = textParams.password
        let validationResult = authManager.validateSignIn(email: email, password: password)
        switch validationResult {
        case .success(let success):
            authManager.signIn(email: email, password: password)
        case .failure(let error):
            delegate?.showSignInValidationErrorMessage(error)
        }
    }
}

protocol SignInViewModelDelegate {
    func showSignInValidationErrorMessage(_ error: AuthValidationError)
}
