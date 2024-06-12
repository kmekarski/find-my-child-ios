//
//  CustomMapPinView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 12/06/2024.
//

import SwiftUI

struct CustomMapPinView: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 50, height: 50)
                .foregroundStyle(.blue)
            Image(systemName: "map")
        }
    }
}

#Preview {
    CustomMapPinView()
}
