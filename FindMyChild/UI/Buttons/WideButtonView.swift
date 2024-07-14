//
//  WideButtonView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 15/06/2024.
//

import SwiftUI

struct WideButtonView: View {
    var text: String
    var isLoading: Bool
    
    init(_ text: String, isLoading: Bool = false) {
        self.text = text
        self.isLoading = isLoading
    }
    
    var body: some View {
        ZStack {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .tint(.onPrimary)
            } else {
                Text(text)
                    .customFont(.regular, 20)
            }
        }
        .foregroundStyle(.onPrimary)
        .padding(12)
        .frame(maxWidth: .infinity)
        .frame(height: 46)
        .background(.prim)
        .clipShape(.rect(cornerRadius: 12))
        .customShadow(.subtleDownShadow)
    }
}

#Preview {
    VStack {
        WideButtonView(String(localized: "sign_up_string"))
        WideButtonView(String(localized: "sign_up_string"), isLoading: true)
    }
        .padding()
}
