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
    
}

class ChildrenManager: ChildrenManagerProtocol {
    var children: [Child] = MockData.children
    var childrenData: [ChildData] = MockData.childrenData
}
