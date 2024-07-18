//
//  NavHeaderTitleView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 18/07/2024.
//

import SwiftUI

struct NavHeaderTitleView: View {
    var title: String
    var body: some View {
        Text(title)
            .customFont(.regular, 22)
            .padding(.horizontal)
    }
}

#Preview {
    let authManager = MockAuthManager()
    return HomeTemplateView(screen: ProfileView(), header: ProfileHeaderView())
        .environmentObject(ProfileViewModel())
        .environmentObject(AuthViewModel(authManager: authManager))
}

