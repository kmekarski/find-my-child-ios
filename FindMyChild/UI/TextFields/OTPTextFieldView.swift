//
//  OTPTextFieldView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 26/07/2024.
//

import SwiftUI
import Combine

struct OtpModifier: ViewModifier {
    
    @Binding var pin : String
    
    var textLimit = 1
    
    func limitText(_ upper : Int) {
        if pin.count > upper {
            self.pin = String(pin.prefix(upper))
        }
    }
    
    func body(content: Content) -> some View {
        content
            .font(.customFont(.regular, 20))
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .onReceive(Just(pin)) {_ in limitText(textLimit)}
            .frame(width: 52, height: 52)
            .background(Color.surface.cornerRadius(5))
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.secondaryContainer, lineWidth: 2)
            )
    }
}

struct OTPTextFieldView: View {
    //MARK -> PROPERTIES
    
    enum FocusPin: Int {
        case  pinOne, pinTwo, pinThree, pinFour
    }
    
    @FocusState private var pinFocusState : FocusPin?
    @State private var pinOne: String = ""
    @State private var pinTwo: String = ""
    @State private var pinThree: String = ""
    @State private var pinFour: String = ""
    
    @Binding var text: String
    
    //MARK -> BODY
    var body: some View {
        HStack(spacing:15) {
            TextField("", text: $pinOne)
                .modifier(OtpModifier(pin:$pinOne))
                .onChange(of:pinOne){_, newVal in
                    changeFocusOnValueChange(newVal, .pinOne)
                }
                .focused($pinFocusState, equals: .pinOne)
            
            TextField("", text:  $pinTwo)
                .modifier(OtpModifier(pin:$pinTwo))
                .onChange(of:pinTwo){_, newVal in
                    changeFocusOnValueChange(newVal, .pinTwo)
                }
                .focused($pinFocusState, equals: .pinTwo)
            
            
            TextField("", text:$pinThree)
                .modifier(OtpModifier(pin:$pinThree))
                .onChange(of:pinThree){_, newVal in
                    changeFocusOnValueChange(newVal, .pinThree)
                }
                .focused($pinFocusState, equals: .pinThree)
            
            
            TextField("", text:$pinFour)
                .modifier(OtpModifier(pin:$pinFour))
                .onChange(of: pinFour){_, newVal in
                    changeFocusOnValueChange(newVal, .pinFour)
                }
                .focused($pinFocusState, equals: .pinFour)
        }
    }
}

private extension OTPTextFieldView {
    func changeFocusOnValueChange(_ newValue: String, _ pin: FocusPin) {
        guard let pinFocusState = pinFocusState else { return }
        if newValue.count >= 1 {
            self.pinFocusState = FocusPin(rawValue: pinFocusState.rawValue + 1) ?? pin
        } else {
            self.pinFocusState = FocusPin(rawValue: pinFocusState.rawValue - 1) ?? pin
        }
        text = getText()
    }
    
    func getText() -> String {
        return [
            pinOne,
            pinTwo,
            pinThree,
            pinFour
        ].filter { pin in
            pin.count == 1
        }.joined()
    }
}

#Preview {
    OTPTextFieldView(text: .constant(""))
}
