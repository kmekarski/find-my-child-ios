//
//  AuthTextFieldView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 15/06/2024.
//

import SwiftUI

struct AuthTextFieldView: View {
    var title: String
        @Binding var text: String
        var onClear: () -> () = {}
        var clearButtonVisible: Bool
        var invalid: Bool = false
    
    var body: some View {
            ZStack(alignment: .trailing) {
                TextField("", text: $text, prompt: Text(title).foregroundColor(.second))
                    .frame(height: 48)
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    .background(.secondaryContainer)
                    .foregroundColor(.onSecondaryContainer)
                    .cornerRadius(10)
                if !text.isEmpty && clearButtonVisible {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.onSecondaryContainer)
                    .padding(.trailing, 16)
                    .onTapGesture {
                        text = ""
                        onClear()
                    }
                }
            }
            .shadow(color: .second, radius: 1)
            .shadow(color: invalid ? .red : .clear, radius: 1)
            .frame(height: 52)
            
        }
}

#Preview {
    var text: String = ""
    return VStack {
        AuthTextFieldView(title: "Email", text: .constant(text), clearButtonVisible: true)
        AuthTextFieldView(title: "Email", text: .constant(text), clearButtonVisible: true)
    }
    .padding(32)
}
