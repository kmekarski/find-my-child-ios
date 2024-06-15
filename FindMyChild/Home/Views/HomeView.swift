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
    @State var selectedItem: HomeViewTab = .status

    var body: some View {
        ZStack {
            MapViewRepresentable(
                mapVM: mapVM,
                homeVM: homeVM
            )
                .ignoresSafeArea()
            VStack {
                Spacer()
                VStack {
                    BottomContentView(selectedItem: selectedItem)
                        .padding(.bottom, 8)
                    BottomTabBarView(selectedItem: $selectedItem)
                }
                .frame(maxWidth: .infinity)
                .background(Material.thick)
            }
            
        }
    }
}

#Preview {
    let childrenManager = MockChildrenManager()
    return HomeView()
        .environmentObject(MapViewModel())
        .environmentObject(HomeViewModel(childrenManager: childrenManager))
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
}
