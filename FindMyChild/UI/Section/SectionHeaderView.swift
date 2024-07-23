//
//  SectionHeaderView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 20/07/2024.
//

import SwiftUI

struct SectionHeaderView: View {
    var title: String
    var body: some View {
        Text(title)
            .customFont(.regular, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom)
    }
}

#Preview {
    SectionHeaderView(title: "Children")
}
