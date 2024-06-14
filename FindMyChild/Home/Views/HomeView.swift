//
//  ContentView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 12/06/2024.
//

import SwiftUI
import MapKit

struct HomeView: View {
    @EnvironmentObject var homeVM: HomeViewModel
    @EnvironmentObject var mapVM: MapViewModel

    var body: some View {
        ZStack {
            MapViewRepresentable(
                mapVM: mapVM,
                children: children,
                childrenData: childrenData
            )
                .ignoresSafeArea()
            VStack {
                Spacer()
                StatusView(
                    children: children,
                           childrenData: childrenData,
                           selectedChild: $homeVM.selectedChild,
                           onChildSelected: selectChild
                )
                .padding(.top, 20)
                .padding(.horizontal, 20)
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
