//
//  SettingsChildrenListAddButtonView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 20/07/2024.
//

import SwiftUI

struct SettingsChildrenListAddButtonView: View {
    var size: CGFloat
    var body: some View {
        ZStack {
            Image(systemName: "plus")
                .font(.system(size: size/2.5))
            Circle()
                .stroke(style: .init(lineWidth: 2, dash: [6, 8]))
                .frame(width: size, height: size)
        }
        .foregroundStyle(.second)
    }
}

#Preview {
    SettingsChildrenListAddButtonView(size: CircleProfileImageSize.small.rawValue)
}
