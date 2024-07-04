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
    
    var selectedChildData: ChildData? {
        guard let selectedChild = selectedChild else {
            return nil
        }
        return childrenData.first { childData in
            childData.childId == selectedChild.id
        }
    }
    
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
