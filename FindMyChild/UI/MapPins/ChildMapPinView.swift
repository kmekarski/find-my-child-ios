//
//  CustomMapPinView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 12/06/2024.
//

import SwiftUI

struct ChildMapPinView: View {
    var child: Child
    var isSelected: Bool
    var body: some View {
        VStack(spacing: 4) {
            ZStack {
                Circle()
                    .foregroundStyle(.prim)
                Image(systemName: "person")
                    .foregroundStyle(.onPrimary)

            }
            .frame(width: 48, height: 48)
            VStack(spacing: 0) {
                Triangle()
                    .frame(width: 20, height: 10)
                    .foregroundStyle(Material.thick)
                Text(child.name)
                    .customFont(.regular, 14)
                    .foregroundStyle(.onPrimaryContainer)
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Material.thick)
                    .clipShape(.rect(cornerRadius: 12))
            }
            .shadow(color: .black.opacity(0.15), radius: 3, y: 3)
            .frame(width: 100, height: 48)
        }
        .offset(x: 50, y: 24)
        .scaleEffect(isSelected ? 1.5 : 1)
    }
}

#Preview {
    HStack {
        ChildMapPinView(child: MockData.children[0], isSelected: false)
        ChildMapPinView(child: MockData.children[1], isSelected: true)
    }
}
