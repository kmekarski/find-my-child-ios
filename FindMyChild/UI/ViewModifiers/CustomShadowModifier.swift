//
//  CustomShadowModifier.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 17/06/2024.
//

import Foundation
import SwiftUI

enum CustomShadowType {
    case subtleOutline
    case subtleDownShadow
    case accentOutline
}
struct CustomShadowModifier: ViewModifier {
    var type: CustomShadowType = .subtleDownShadow
    var cornerRadius: CGFloat?
    func body(content: Content) -> some View {
        switch type {
        case .subtleOutline:
            return AnyView(content
                .shadow(color: .outline, radius: 1))
        case .accentOutline:
            return AnyView(content
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius ?? 16)
                        .stroke(.prim, lineWidth: 3))
                )
        case.subtleDownShadow:
                    return AnyView(content
                        .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 5))
        }
    }
}
