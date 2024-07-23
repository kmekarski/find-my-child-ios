//
//  SettingsChildrenListItemView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 20/07/2024.
//

import SwiftUI

struct SettingsChildrenListItemView: View {
    var child: Child
    var size: CircleProfileImageSize
    var body: some View {
        let url = URL(string: "")
        return VStack {
            CircleProfileImageView(url: url, size: size)
                .padding(.bottom, 8)
            Text(child.name)
                .customFont(.light, 18)
        }
    }
}

#Preview {
    SettingsChildrenListItemView(child: MockData.children[0], size: CircleProfileImageSize.medium)
}
