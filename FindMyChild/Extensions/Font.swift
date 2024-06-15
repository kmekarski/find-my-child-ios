//
//  Font.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 14/06/2024.
//

import Foundation
import SwiftUI

enum FontWeight {
    case light
    case regular
    case bold
}

extension Font {
    static let customFont: (FontWeight, CGFloat) -> Font = { fontType, size in
        switch fontType {
        case .light:
            Font.custom("HelveticaNeue-Light", size: size)
        case .regular:
            Font.custom("HelveticaNeue-Medium", size: size)
        case .bold:
            Font.custom("HelveticaNeue-Bold", size: size)
        }
    }
}

extension Text {
    func customFont(_ fontWeight: FontWeight? = .regular, _ size: CGFloat? = nil) -> Text {
        return self.font(.customFont(fontWeight ?? .regular, size ?? 16))
    }
}
