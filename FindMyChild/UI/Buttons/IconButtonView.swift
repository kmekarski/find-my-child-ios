//
//  IconButtonView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 22/06/2024.
//

import SwiftUI

enum IconButtonSize: CGFloat {
    case small = 32
    case medium = 40
    case large = 50
}

struct IconButtonView: View {
    var icon: String
    var size: IconButtonSize = .medium
    var body: some View {
        Image(systemName: icon)
            .foregroundStyle(.prim)
            .fontWeight(.semibold)
            .frame(width: size.rawValue, height: size.rawValue)
            .background(Material.thick)
            .clipShape(Circle())
            .customShadow(.subtleOutline)

    }
}

#Preview {
    HStack {
        IconButtonView(icon: "chevron.down")
        IconButtonView(icon: "line.3.horizontal")
        IconButtonView(icon: "person")

    }
}
