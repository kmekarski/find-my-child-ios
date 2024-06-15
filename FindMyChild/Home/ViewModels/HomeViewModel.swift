//
//  HomeViewModel.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 14/06/2024.
//

import Foundation

class HomeViewModel: ObservableObject {
    var childrenManager: ChildrenManagerProtocol
    @Published var children: [Child]
    @Published var childrenData: [ChildData]
    @Published var selectedChild: Child?
    
    init(childrenManager: ChildrenManagerProtocol) {
        self.childrenManager = childrenManager
        self.children = childrenManager.children
        self.selectedChild = childrenManager.children.first
        self.childrenData = childrenManager.childrenData
    }
    
    func selectChild(_ child: Child) {
        selectedChild = child
    }
}
