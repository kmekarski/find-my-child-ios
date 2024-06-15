//
//  Navigation.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 14/06/2024.
//

import Foundation

protocol Route {
    
}

protocol NavigationViewModel: ObservableObject {
    associatedtype R: Route
    func navigate(route: R)
    func pop()
}
