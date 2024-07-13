//
//  UserTypeButtonView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 25/06/2024.
//

import SwiftUI

struct UserTypeButtonView: View {
    var type: UserType
    var isSelected: Bool
    var action: (UserType) -> ()
    var body: some View {
        Button(action: { action(type) }, label: {
            VStack {
                Image(systemName: type.icon)
                    .font(.system(size: 36))
                    .padding(.bottom, 2)
                Text(type.text)
                    .customFont(.regular, 20)
            }
            .foregroundStyle(isSelected ? .prim : .second)
            .frame(maxWidth: .infinity)
            .padding(24)
            .background(.surface)
            .clipShape(.rect(cornerRadius: 16))
            .customShadow(isSelected ? .accentOutline : .subtleOutline)
        })
    }
}

#Preview {
    HStack {
        UserTypeButtonView(type: .child, isSelected: false, action: {_ in })
        UserTypeButtonView(type: .parent, isSelected: true, action: {_ in })
    }
        .padding()
}
