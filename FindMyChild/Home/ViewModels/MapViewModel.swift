//
//  MapStateManager.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 12/06/2024.
//

import Foundation

enum MapViewsState {
    case initial
    case annotationsAdded
}

class MapViewModel: ObservableObject {
    @Published var currentState: MapViewsState
    @Published var selectedAnnotation: Child?
    
    init() {
        self.currentState = .initial
    }
    
    func go(to: MapViewsState) {
        currentState = to
    }
}
