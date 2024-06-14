//
//  MockChildrenManager.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 14/06/2024.
//

import Foundation

class MockChildrenManager: ChildrenManagerProtocol {
    var children: [Child] = MockData.children
    var childrenData: [ChildData] = MockData.childrenData
}
