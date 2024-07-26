//
//  SettingsView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 14/07/2024.
//

import SwiftUI

struct SettingsView: HomeScreenProtocol {
    @EnvironmentObject var profileVM: ProfileViewModel
    @EnvironmentObject var authVM: AuthViewModel
    let type: AppRoute = .settings
    var body: some View {
        VStack {
            if let user = authVM.currentUser, user.type == .parent {
                SectionHeaderView(title: "Children")
                SettingsChildrenListView(children: user.children)
                    .padding(.bottom)
            }
            SectionHeaderView(title: "Settings")
            Spacer()
        }
    }
}

#Preview("3 children") {
    let authManager = MockAuthManager()
    return HomeTemplateView(screen: SettingsView(), header: SettingsHeaderView())
        .environmentObject(ProfileViewModel())
        .environmentObject(AuthViewModel(authManager: authManager))
}

#Preview("No children") {
    let authManager = MockAuthManager()
    var authVM = AuthViewModel(authManager: authManager)
    var user = MockData.childlessParentUser
    authVM.currentUser = user
    return HomeTemplateView(screen: SettingsView(), header: SettingsHeaderView())
        .environmentObject(ProfileViewModel())
        .environmentObject(authVM)
}
