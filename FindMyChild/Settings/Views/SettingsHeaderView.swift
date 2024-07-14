//
//  SettingsHeaderView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 14/07/2024.
//

import SwiftUI

struct SettingsHeaderView: HomeHeaderProtocol {
    @EnvironmentObject var navVM: HomeNavigationViewModel
    var body: some View {
        HStack {
            Button(action: goBack, label: {
                IconButtonView(icon: "chevron.left")
            })
            Spacer()
        }
    }
}

#Preview {
    HomeTemplateView(screen: SettingsView(), header: SettingsHeaderView())
        .environmentObject(HomeNavigationViewModel())
}

extension SettingsHeaderView {
    func goBack() {
        navVM.pop()
    }
}
