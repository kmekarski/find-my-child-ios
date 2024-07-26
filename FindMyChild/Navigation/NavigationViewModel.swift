//
//  NavigationViewModel.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 26/07/2024.
//

import Foundation
import SwiftUI
import Combine

enum AppRoute: String, Hashable {
    case signIn
    case signUp
    case chooseUserType
    case map
    case settings
    case profile
    case parentOnboarding
}

class NavigationViewModel: ObservableObject {
    var authManager: AuthManagerProtocol
    private var cancellables = Set<AnyCancellable>()
    
    @Published var path = NavigationPath()
    
    init(authManager: AuthManagerProtocol) {
        self.authManager = authManager
        authManager.statePublisher
                    .receive(on: DispatchQueue.main)
                    .sink { [weak self] state in
                        switch state {
                        case .signedIn(let user), .signedUp(let user):
                            self?.didAuthenticate(result: .success(user))
                        case .signedOut:
                            self?.didSignOut()
                        default:
                            break
                        }
                    }
                    .store(in: &cancellables)
    }
    
    func navigate(route: AppRoute)  {
        path.append(route)
    }
    
    func pop()  {
        path.removeLast()
    }
    
    func popToRoot() {
        path = NavigationPath()
    }
}

extension NavigationViewModel {
    func didAuthenticate(result: AuthResult) {
        switch result {
        case .success(_): navigate(route: .map)
        case .failure(_): break
        }
    }
    
    func didSignOut() {
        navigate(route: .signIn)
    }
}
