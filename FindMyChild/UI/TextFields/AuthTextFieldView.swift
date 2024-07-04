//
//  AuthTextFieldView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 15/06/2024.
//

import SwiftUI

enum TextFieldType {
    case normal
    case email
    case password
    case phoneNumber
    
    var isSecure: Bool {
        return self == .password
    }
    
    var hasAutocorrect: Bool {
        return self == .normal
    }
}

struct AuthTextFieldView: View {
    var title: String
    @Binding var text: String
    var type: TextFieldType = .normal

    @State var showSecureText: Bool = false
    var invalid: Bool = false
    
    var body: some View {
            let showSecureField = type.isSecure && !showSecureText
           return ZStack(alignment: .trailing) {
                
                if !showSecureField {
                    TextField("", text: $text, prompt: Text(title).foregroundColor(.second))
                        .modifier(AuthTextFieldModifier())
                }
                
                if showSecureField {
                    SecureField("", text: $text, prompt: Text(title).foregroundColor(.second))
                        .modifier(AuthTextFieldModifier())
                }
                
                if type.isSecure {
                    Button(action: toggleSecureText, label: {
                        Image(systemName: showSecureText ? "eye.slash" : "eye")
                    })
                    .padding(.trailing, 12)
                }

            }
            .shadow(color: .outline, radius: 1)
            .shadow(color: invalid ? .red : .clear, radius: 1)
            .frame(height: 52)
            
        }
}

extension AuthTextFieldView {
    func toggleSecureText() {
        showSecureText.toggle()
    }
}

#Preview {
    return VStack {
        AuthTextFieldView(title: "Email", text: .constant("text"), type: .email)
        AuthTextFieldView(title: "Password", text: .constant("password"), type: .password)
    }
    .padding(32)
}

struct AuthTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
            return content
            .frame(height: 48)
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            .background(.surface)
            .foregroundColor(.onSecondaryContainer)
            .cornerRadius(10)
    }
}
