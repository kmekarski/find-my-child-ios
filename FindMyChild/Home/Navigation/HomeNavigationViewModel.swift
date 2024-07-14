//
//  HomeNavigationViewModel.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 14/07/2024.
//

import Foundation
import SwiftUI

enum HomeScreenType: Route {
    case map
    case settings
    case profile
}

class HomeNavigationViewModel: NavigationViewModel {
    @Published var path = NavigationPath()
    
    func navigate(route: HomeScreenType)  {
        path.append(route)
    }
    
    func pop()  {
        path.removeLast()
    }
    
    func popToRoot() {
        path = NavigationPath()
    }
}
