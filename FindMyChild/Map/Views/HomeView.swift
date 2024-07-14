//
//  ContentView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 12/06/2024.
//

import SwiftUI
import MapKit

enum HomeViewTab: CaseIterable {
    case status
    case history
}

struct HomeView: HomeScreenProtocol {
    @EnvironmentObject var homeVM: HomeViewModel
    @EnvironmentObject var mapVM: MapViewModel
    @EnvironmentObject var authVM: AuthViewModel
    @State var selectedItem: HomeViewTab = .status
    var type: HomeScreenType = .map
    var body: some View {
        ZStack {
            map
            overlay
        }
        .ignoresSafeArea(edges: [.bottom])
    }
}

#Preview {
    let childrenManager = MockChildrenManager()
    let authManager = MockAuthManager()
    return HomeView()
        .environmentObject(MapViewModel())
        .environmentObject(HomeViewModel(childrenManager: childrenManager))
        .environmentObject(AuthViewModel(authManager: authManager))
}

private extension HomeView {
    var children: [Child] {
        return homeVM.children
    }
    
    var childrenData: [ChildData] {
        return homeVM.childrenData
    }
    
    func selectChild(child: Child) {
        homeVM.selectChild(child)
    }
    
    var map: some View {
        MapViewRepresentable(
            mapVM: mapVM,
            homeVM: homeVM
        )
        .ignoresSafeArea()
    }
    
    var overlay: some View {
        VStack {
            Spacer()
            bottomOverlay
        }
    }
    
    var bottomOverlay: some View {
        VStack {
            ChildHeaderView()
            BottomContentView(selectedItem: selectedItem)
                .padding(.bottom, 8)
                .animation(nil, value: UUID())
            Divider()
            BottomTabBarView(selectedItem: $selectedItem)
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .background(Material.thick)
    }
}
