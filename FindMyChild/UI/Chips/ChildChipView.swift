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
            .padding(.horizontal)
            .padding(.vertical, 8)
            .foregroundStyle(isSelected ? .white : .black)
            .font(.system(size: 12, weight: .bold))
            .background()
            .backgroundStyle(isSelected ? .blue : Color(.systemGray3))
            .clipShape(.capsule)
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
