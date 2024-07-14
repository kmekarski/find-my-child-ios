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
    @EnvironmentObject var navVM: HomeNavigationViewModel
    var body: some View {
        HStack {
            Button(action: goToSettings, label: {
                IconButtonView(icon: "line.3.horizontal")
            })
            Spacer()
            Image(systemName: "bell.fill")
                .foregroundStyle(.prim)
            Button(action: signOut, label: {
                Text("Sign out")
            })
            Button(action: goToProfile, label: {
                IconButtonView(icon: "person")
            })
        }
    }
}

#Preview {
    let childrenManager = MockChildrenManager()
    let authManager = MockAuthManager()
    return HomeTemplateView(screen: HomeView(), header: MapHeaderView())
        .environmentObject(HomeViewModel(childrenManager: childrenManager))
        .environmentObject(AuthViewModel(authManager: authManager))
        .environmentObject(MapViewModel())
        .environmentObject(HomeNavigationViewModel())
}

extension MapHeaderView {
    func signOut() {
        authVM.signOut()
    }
    
    func goToSettings() {
        navVM.navigate(route: .settings)
    }
    
    func goToProfile() {
        navVM.navigate(route: .profile)
    }
}
