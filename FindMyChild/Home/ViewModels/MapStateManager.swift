//
//  MapStateManager.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 12/06/2024.
//

import Foundation

enum MapViewState {
    case initial
    case annotationsAdded
}

class MapViewModel: ObservableObject {
    @Published var currentState: MapViewState = .initial
    
    func go(to: MapViewState) {
        currentState = to
    }
}
