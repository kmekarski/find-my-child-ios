//
//  ProfileHeaderView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 14/07/2024.
//

import SwiftUI

struct ProfileHeaderView: HomeHeaderProtocol {
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
