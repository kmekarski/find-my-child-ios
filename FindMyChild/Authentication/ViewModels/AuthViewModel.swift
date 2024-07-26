//
//  AuthViewModel.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 25/06/2024.
//

import Foundation
import SwiftUI
import Combine

class AuthViewModel: ObservableObject {
    var authManager: AuthManagerProtocol
    private var cancellables = Set<AnyCancellable>()
    
    @Published var currentUser: User?
    @Published var isSignedIn: Bool = false
    @Published var isAuthenticating: Bool = false
    @Published var toast: Toast?
    
    init(authManager: AuthManagerProtocol) {
        self.authManager = authManager
        authManager.statePublisher
                    .receive(on: DispatchQueue.main)
                    .sink { [weak self] state in
                        switch state {
                        case .authenticating:
                            self?.didStartAuthenticating()
                        case .error(let error):
                            self?.didAuthenticate(result: .failure(error))
                        case .signedIn(let user), .signedUp(let user):
                            self?.didAuthenticate(result: .success(user))
                        case .signedOut:
                            self?.didSignOut()
                        default:
                            self?.isAuthenticating = false
                        }
                    }
                    .store(in: &cancellables)
        Task {
            await self.authManager.checkAuthentication()
        }
    }
    
    func signOut() {
        authManager.signOut()
    }
    
    private func showErrorToast(error: any AuthErrorProtocol) {
        toast = Toast(style: .error, message: error.message)
    }
}

extension AuthViewModel {
    func didStartAuthenticating() {
        DispatchQueue.main.async {
            self.isAuthenticating = true
        }
    }
    
    func didAuthenticate(result: AuthResult) {
        DispatchQueue.main.async {
            self.isAuthenticating = false
            switch result {
            case .success(let authUser):
                withAnimation() {
                    self.isSignedIn = true
                }
                self.currentUser = authUser
            case .failure(let error):
                self.showErrorToast(error: error)
            }
        }
    }
    
    func didSignOut() {
        DispatchQueue.main.async {
            self.isAuthenticating = false
            withAnimation() {
                self.isSignedIn = false
            }
        }
    }
}
