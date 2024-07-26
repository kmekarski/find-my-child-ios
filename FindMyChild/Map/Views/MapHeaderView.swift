//
//  HomeHeaderView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 14/07/2024.
//

import SwiftUI

struct MapHeaderView: HomeHeaderProtocol {
    @EnvironmentObject var homeVM: HomeViewModel
    @EnvironmentObject var mapVM: MapViewModel
    @EnvironmentObject var authVM: AuthViewModel
    @EnvironmentObject var navVM: NavigationViewModel
    var title: String? = nil
    var body: some View {
        let leftItems = [
            Button(action: goToSettings, label: {
                IconButtonView(icon: "line.3.horizontal")
            })
        ]
        let currentUser = authVM.currentUser
        let currentUserName = currentUser?.username
        let urlString = currentUser?.imageUrl ?? "no url found"
        let profileImageUrl = URL(string: urlString)
        let rightItems = [
            Image(systemName: "bell.fill")
                .foregroundStyle(.prim),
            Button(action: goToProfile, label: {
                CircleProfileImageView(url: profileImageUrl, size: .headerItem)
            })
        ] as [Any]
        let headerData = HomeHeaderData(leftItems: leftItems, rightItems: rightItems)
        return HomeHeaderTemplateView(data: headerData)
    }
}

#Preview {
    let childrenManager = MockChildrenManager()
    let authManager = MockAuthManager()
    return HomeTemplateView(screen: HomeView(), header: MapHeaderView())
        .environmentObject(HomeViewModel(childrenManager: childrenManager))
        .environmentObject(AuthViewModel(authManager: authManager))
        .environmentObject(MapViewModel())
        .environmentObject(NavigationViewModel(authManager: authManager))
}

extension MapHeaderView {
    func goToSettings() {
        navVM.navigate(route: .settings)
    }
    
    func goToProfile() {
        navVM.navigate(route: .profile)
    }
}
