//
//  HomeNavigationView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 14/07/2024.
//

import Foundation
import SwiftUI

struct HomeNavigationView: View {
    @EnvironmentObject var navVM: HomeNavigationViewModel
    var body: some View {
        NavigationStack(path: $navVM.path) {
            HomeTemplateView(screen: HomeView(), header: MapHeaderView())
                .navigationDestination(for: HomeScreenType.self) { screenType in
                    switch screenType {
                    case .map: HomeTemplateView(screen: HomeView(), header: MapHeaderView())
                    case .settings: HomeTemplateView(screen: SettingsView(), header: SettingsHeaderView())
                    case .profile: HomeTemplateView(screen: ProfileView(), header: ProfileHeaderView())
                    }
                }
        }
    }
}

#Preview {
    let childrenManager = MockChildrenManager()
    let authManager = MockAuthManager()
    return HomeNavigationView()
        .environmentObject(HomeNavigationViewModel())
        .environmentObject(MapViewModel())
        .environmentObject(HomeViewModel(childrenManager: childrenManager))
        .environmentObject(AuthViewModel(authManager: authManager))
}
