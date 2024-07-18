//
//  ProfileHeaderView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 14/07/2024.
//

import SwiftUI

struct ProfileHeaderView: HomeHeaderProtocol {
    @EnvironmentObject var navVM: HomeNavigationViewModel
    var title: String? = "Profile"
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
    let authManager = MockAuthManager()
    return HomeTemplateView(screen: ProfileView(), header: ProfileHeaderView())
        .environmentObject(HomeNavigationViewModel())
        .environmentObject(AuthViewModel(authManager: authManager))
}

extension ProfileHeaderView {
    func goBack() {
        navVM.pop()
    }
}
