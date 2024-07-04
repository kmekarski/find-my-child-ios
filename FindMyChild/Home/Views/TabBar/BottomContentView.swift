//
//  BottomTabView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 15/06/2024.
//

import SwiftUI

struct BottomContentView: View {
    @EnvironmentObject var homeVM: HomeViewModel
    @EnvironmentObject var mapVM: MapViewModel
    var selectedItem: HomeViewTab
    
    var body: some View {
        VStack {
            switch selectedItem {
            case .status:
                StatusView()
            case .history:
                HistoryView()
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

private extension BottomContentView {
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
