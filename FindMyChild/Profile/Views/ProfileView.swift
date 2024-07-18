//
//  ProfileView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 14/07/2024.
//

import SwiftUI

struct ProfileView: HomeScreenProtocol {
    var type: HomeScreenType = .profile
    @EnvironmentObject var profileVM: ProfileViewModel
    @EnvironmentObject var authVM: AuthViewModel
    var body: some View {
        VStack {
            CircleProfileImageView(size: .large)
            if let user = authVM.currentUser {
                Text(user.username)
                Text(user.email)
                Text(user.phoneNumber)
                Text(user.type.rawValue)
                if let childrenCount = (user as? ParentUser)?.children.count {
                    Text("\(childrenCount)")
                }
                if let childProperty = (user as? ChildUser)?.childProperty {
                    Text(childProperty)
                }
            }
            Spacer()
        }
        .offset(y: -40)
    }
}

#Preview {
    let authManager = MockAuthManager()
    return HomeTemplateView(screen: ProfileView(), header: ProfileHeaderView())
        .environmentObject(ProfileViewModel())
        .environmentObject(AuthViewModel(authManager: authManager))
}
