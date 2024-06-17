//
//  CustomShadowModifier.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 17/06/2024.
//

import Foundation
import SwiftUI

enum CustomShadowType {
    case outline
    case subtleDownShadow
}
struct CustomShadowModifier: ViewModifier {
    var type: CustomShadowType = .subtleDownShadow
    func body(content: Content) -> some View {
        switch type {
        case .outline:
            return content
                .shadow(color: .outline, radius: 1)
        case.subtleDownShadow:
                    return content
                        .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 5)
        }
    }
}
