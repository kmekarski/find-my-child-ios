//
//  SettingsChildrenListView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 20/07/2024.
//

import SwiftUI

struct SettingsChildrenListView: View {
    var children: [Child]
    let childrenItemSize = CircleProfileImageSize.medium
    var body: some View {
        if children.count == 0 {
            SettingsNoChildrenMessageView()
        } else {
            ScrollView(.horizontal) {
                HStack(alignment: .top, spacing: 24) {
                    ForEach(children) { child in
                        SettingsChildrenListItemView(child: child, size: childrenItemSize)
                    }
                    SettingsChildrenListAddButtonView(size: childrenItemSize.rawValue)
                }
                .padding(.horizontal, 8)
                .padding(.top, 2)
                .padding(.bottom)
            }
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
