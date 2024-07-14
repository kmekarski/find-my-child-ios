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

struct HomeView: View {
    @EnvironmentObject var homeVM: HomeViewModel
    @EnvironmentObject var mapVM: MapViewModel
    @EnvironmentObject var authVM: AuthViewModel
    @State var selectedItem: HomeViewTab = .status

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
            topOverlay
            Spacer()
            bottomOverlay
        }
    }
    
    var topOverlay: some View {
        VStack {
            HStack {
                IconButtonView(icon: "line.3.horizontal")
                Spacer()
                Image(systemName: "bell.fill")
                    .foregroundStyle(.prim)
                Button(action: signOut, label: {
                    Text("Sign out")
                })
                IconButtonView(icon: "person")
            }
            .padding(.horizontal)
            .padding(.bottom)
            .frame(maxWidth: .infinity)
            .background(Material.thick)
            .padding(.bottom, 4)
            HStack {
                ChildSelectorView(children: children, childrenData: childrenData, selectedChild: $homeVM.selectedChild, onChildSelected: selectChild)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
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
    
    func signOut() {
        authVM.signOut()
    }
}
