//
//  View.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 17/06/2024.
//

import Foundation
import SwiftUI

extension View {
    func customShadow(_ type: CustomShadowType) -> some View {
        modifier(CustomShadowModifier(type: type))
    }
    
    func toastView(toast: Binding<Toast?>) -> some View {
        self.modifier(ToastModifier(toast: toast))
      }
}
