//
//  IconButtonView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 22/06/2024.
//

import SwiftUI

struct IconButtonView: View {
    var icon: String
    var size: CGFloat = 40
    var body: some View {
        Image(systemName: icon)
            .foregroundStyle(.prim)
            .frame(width: size, height: size)
            .background(Material.thick)
            .clipShape(Circle())
            .customShadow(.outline)

    }
}

#Preview {
    HStack {
        IconButtonView(icon: "chevron.down")
        IconButtonView(icon: "line.3.horizontal")
        IconButtonView(icon: "person")

    }
}
