//
//  SettingsNoChildrenMessageView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 20/07/2024.
//

import SwiftUI

struct SettingsNoChildrenMessageView: View {
    var body: some View {
        Text("No children added. Add some!")
            .customFont(.light)
            .padding()
            .padding(.horizontal)
            .overlay {
                RoundedRectangle(cornerRadius: 24).stroke(style: .init(lineWidth: 2, dash: [6,10]))
            }
            .foregroundStyle(.second)
    }
}

#Preview {
    SettingsNoChildrenMessageView()
}
