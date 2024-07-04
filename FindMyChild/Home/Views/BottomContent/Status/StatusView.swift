//
//  StatusView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 14/06/2024.
//

import SwiftUI

struct StatusView: View {
    @EnvironmentObject var homeVM: HomeViewModel
    var body: some View {
        VStack {            
            if let selectedChild = selectedChild,
               let selectedChildData = selectedChildData {
                ChildStatusView(child: selectedChild, childData: selectedChildData)
            }
        }
    }
}

private extension StatusView {
    var children: [Child] {
        return homeVM.children
    }
    
    var childrenData: [ChildData] {
        return homeVM.childrenData
    }
    
    func selectChild(child: Child) {
        homeVM.selectChild(child)
    }
    
    var selectedChild: Child? {
        homeVM.selectedChild
    }
    
    var selectedChildData: ChildData? {
        homeVM.selectedChildData
    }
}

#Preview {
    let childrenManager = MockChildrenManager()
    return HomeView()
        .environmentObject(HomeViewModel(childrenManager: childrenManager))
        .environmentObject(MapViewModel())
}
