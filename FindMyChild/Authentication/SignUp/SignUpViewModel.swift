//
//  SignUpViewModel.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 13/06/2024.
//

import Foundation
import SwiftUI

class SignUpViewModel: ObservableObject {
    var delegate: SignUpViewModelDelegate?
    var authManager: AuthManagerProtocol
    
    @Published var textParams: SignUpTextParams = SignUpTextParams()
    
    @Published var selectedAccountType: UserType? = .parent
    
    init(authManager: AuthManagerProtocol) {
        self.authManager = authManager
    }
    
    func signUp() {
        let username = textParams.name
        let email = textParams.email
        let password = textParams.password
        let repeatPassword = textParams.repeatPassword
        let phoneNumber = textParams.phoneNumber
        let validationResult = authManager.validateSignUp(
            username: username,
            email: email,
            password: password,
            repeatPassword: repeatPassword,
            phoneNumber: phoneNumber
        )
        switch validationResult {
        case .success(let success):
            break
        case .failure(let error):
            delegate?.showErrorMessage(error)
        }
    }
}

protocol SignUpViewModelDelegate {
    func showErrorMessage(_ error: SignUpError)
}
