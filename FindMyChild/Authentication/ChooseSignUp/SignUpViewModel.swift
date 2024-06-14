//
//  SignUpViewModel.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 13/06/2024.
//

import Foundation

class SignUpViewModel: ObservableObject {
    var authManager: AuthManager
    
    init(authManager: AuthManager) {
        self.authManager = authManager
    }
    
    func signUp() {
        
    }
}
