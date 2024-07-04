//
//  ChildChipView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 14/06/2024.
//

import SwiftUI

struct ChildChipView: View {
    var child: Child
    var isSelected: Bool
    var body: some View {
        Text(child.name)
            .customFont(.bold, 18)
            .padding(.horizontal)
            .padding(.vertical, 8)
            .foregroundStyle(isSelected ? .onPrimary : .onPrimaryContainer)
            .background()
            .backgroundStyle(isSelected ? .prim : .secondaryContainer)
            .clipShape(.capsule)
            .customShadow(.outline)
    }
}

#Preview {
    let selectedChildIndex = 0
    return HStack {
        ForEach(MockData.children.indices, id: \.self) { index in
            ChildChipView(child: MockData.children[index], isSelected: index == selectedChildIndex)
        }
    }
}
