//
//  SettingsHeaderView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 14/07/2024.
//

import SwiftUI

struct SettingsHeaderView: HomeHeaderProtocol {
    var title: String? = "Settings"
    @EnvironmentObject var navVM: HomeNavigationViewModel
    var body: some View {
        let leftItems = [
            Button(action: goBack, label: {
                IconButtonView(icon: "chevron.left")
            })
        ]
        let headerData = HomeHeaderData(title: title, leftItems: leftItems)
        return HomeHeaderTemplateView(data: headerData)
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
