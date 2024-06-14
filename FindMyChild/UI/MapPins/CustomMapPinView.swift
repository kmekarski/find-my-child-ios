//
//  CustomMapPinView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 12/06/2024.
//

import SwiftUI

struct CustomMapPinView: View {
    var childName: String
    var body: some View {
        VStack(spacing: 4) {
            ZStack {
                Circle()
                    .foregroundStyle(.blue)
                Image(systemName: "person")
            }
            .frame(width: 48, height: 48)

            
            VStack(spacing: 0) {
                Triangle()
                    .frame(width: 20, height: 10)
                    .foregroundStyle(Material.thick)
                Text(childName)
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Material.thick)
                    .clipShape(.rect(cornerRadius: 12))
            }
        }
        .frame(width: 100, height: 48)
    }
}

#Preview {
    CustomMapPinView(childName: MockData.children[0].name)
}
