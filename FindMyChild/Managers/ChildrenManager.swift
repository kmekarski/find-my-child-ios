//
//  ChildrenManager.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 14/06/2024.
//

import Foundation

protocol ChildrenManagerProtocol {
    var children: [Child] { get }
    var childrenData: [ChildData] { get }
    func getChildWithId(_ id: String) -> Child?
    
}

class ChildrenManager: ChildrenManagerProtocol {
    var children: [Child] = MockData.children
    var childrenData: [ChildData] = MockData.childrenData
    
    func getChildWithId(_ id: String) -> Child? {
        return children.first { child in
            child.id == id
        }
    }
}
