//
//  SignUpViewModel.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 13/06/2024.
//

import Foundation
import SwiftUI

class SignUpViewModel: ObservableObject {
    var authManager: AuthManager
    
    @Published var formTextData: [SignUpTextField: String] = Dictionary(uniqueKeysWithValues: SignUpTextField.allCases.map({ ($0, "")
    }))
    
    @Published var selectedAccountType: UserType?
    
    init(authManager: AuthManager) {
        self.authManager = authManager
    }
    
    func signUp() {
        print(selectedAccountType)
        print(formTextData)
    }
    
    func binding(for field: SignUpTextField) -> Binding<String> {
            return Binding(
                get: { self.formTextData[field, default: ""] },
                set: { self.formTextData[field] = $0 }
            )
        }
}
