//
//  AuthFormTitleView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 26/07/2024.
//

import SwiftUI

struct AuthFormTitleView: View {
    var text: String
    var body: some View {
        Text(text)
            .foregroundStyle(.prim)
            .customFont(.regular, 20)
            .padding(.bottom, 12)
    }
}

#Preview {
    AuthFormTitleView(text: "User details")
}
