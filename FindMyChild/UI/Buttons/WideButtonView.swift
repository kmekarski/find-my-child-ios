//
//  WideButtonView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 15/06/2024.
//

import SwiftUI

struct WideButtonView: View {
    var text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .customFont(.bold, 24)
            .foregroundStyle(.prim)
            .padding(12)
            .frame(maxWidth: .infinity)
            .background(.primaryContainer)
            .clipShape(.rect(cornerRadius: 12))
    }
}

#Preview {
    WideButtonView(String(localized: "sign_up_string"))
        .padding()
}
