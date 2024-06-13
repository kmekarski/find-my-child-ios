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

class MapStateManager: ObservableObject {
    @Published var current: MapViewState = .initial
    
    func go(to: MapViewState) {
        current = to
    }
}
