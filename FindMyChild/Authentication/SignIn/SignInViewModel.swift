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
    
    init(authManager: AuthManagerProtocol) {
        self.authManager = authManager
    }
    
    func signIn() {
        print(textParams.email)
        print(textParams.password)
        authManager.signIn()
    }
}
