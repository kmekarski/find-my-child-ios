//
//  AuthNavigationViewModel.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 14/06/2024.
//

import Foundation
import SwiftUI

enum AuthScreenType: String, Hashable, Route {
    case signIn
    case signUp
    case chooseUserType
    
    var showBackButton: Bool {
        switch self {
        case .signIn:
            return false
        case .signUp, .chooseUserType:
            return true
        }
    }
}

class AuthNavigationViewModel: NavigationViewModel {
    @Published var path = NavigationPath()
    
    func navigate(route: AuthScreenType)  {
        path.append(route)
    }
    
    func pop()  {
        path.removeLast()
    }
    
    func popToRoot() {
        path = NavigationPath()
    }
}
