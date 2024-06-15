//
//  HistoryVie.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 15/06/2024.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var homeVM: HomeViewModel
    var body: some View {
        VStack {
            ChildSelectorView(
                children: children,
                childrenData: childrenData,
                selectedChild: $homeVM.selectedChild,
                onChildSelected: selectChild
            )
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

extension HistoryView {
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

#Preview {
    let childrenManager = MockChildrenManager()
    return HistoryView()
        .environmentObject(HomeViewModel(childrenManager: childrenManager))
}
