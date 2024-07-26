//
//  ProfileView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 14/07/2024.
//

import SwiftUI

struct ProfileView: HomeScreenProtocol {
    @EnvironmentObject var profileVM: ProfileViewModel
    @EnvironmentObject var authVM: AuthViewModel
    let type: AppRoute = .profile
    var body: some View {
        VStack {
            if let url = URL(string: authVM.currentUser?.imageUrl ?? "") {
                CircleProfileImageView(url: url, size: .large)
                    .padding(.bottom)
            }
            if let user = authVM.currentUser {
                generalInfo(user)
                    .padding(.bottom, 24)
            }
            settingsList
            Spacer()
            logoutButton
        }
    }
}

#Preview {
    let authManager = MockAuthManager()
    return HomeTemplateView(screen: ProfileView(), header: ProfileHeaderView())
        .environmentObject(ProfileViewModel())
        .environmentObject(AuthViewModel(authManager: authManager))
}

extension ProfileView {
    func generalInfo(_ user: User) -> some View {
        return VStack(spacing: 10) {
            Text(user.username)
                .customFont(.regular, 24)
            Text(user.email)
        }
    }
    
    var settingsList: some View {
        let settingsRowsData = [
            SettingsRowData(title: "Change password", iconName: "lock.fill") {},
            SettingsRowData(title: "Change password", iconName: "lock.fill") {},
            SettingsRowData(title: "Change password", iconName: "lock.fill") {},
        ]
        return SettingsListView(title: "Account settings", rowsData: settingsRowsData)
    }
    
    var logoutButton: some View {
        let data = SettingsRowData(title: "Logout", iconName: "lock.fill", type: .centered) {
            authVM.signOut()
        }
        return SettingsListRowView(data: data)
    }
}
