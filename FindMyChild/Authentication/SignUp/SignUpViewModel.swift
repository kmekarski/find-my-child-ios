//
//  SignUpViewModel.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 13/06/2024.
//

import Foundation
import SwiftUI

class SignUpViewModel: ObservableObject {
    var authManager: AuthManagerProtocol
    
    @Published var textParams: SignUpTextParams = SignUpTextParams()
    
    @Published var selectedAccountType: UserType?
    
    init(authManager: AuthManagerProtocol) {
        self.authManager = authManager
    }
    
    func signUp() {
        print(textParams.name)
        print(textParams.email)
        print(textParams.password)
        print(textParams.repeatPassword)
        print(textParams.phoneNumber)
        print(selectedAccountType)
    }
}
