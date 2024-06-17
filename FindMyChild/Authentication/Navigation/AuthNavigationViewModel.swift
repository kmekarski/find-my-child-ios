//
//  AuthNavigationViewModel.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 14/06/2024.
//

import Foundation
import SwiftUI

enum AuthRoute: String, Hashable, Route {
    case signIn
    case signUp
}

class AuthNavigationViewModel: NavigationViewModel {
    @Published var path = NavigationPath()
    
    func navigate(route: AuthRoute)  {
        path.append(route)
    }
    
    func pop()  {
        path.removeLast()
    }
    
    func popToRoot() {
        path = NavigationPath()
    }
}
