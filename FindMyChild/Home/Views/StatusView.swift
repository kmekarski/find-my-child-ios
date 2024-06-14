//
//  StatusView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 14/06/2024.
//

import SwiftUI

struct StatusView: View {
    var children: [Child]
    var childrenData: [ChildData]
    @Binding var selectedChild: Child?
    var onChildSelected: (Child) -> ()
    var body: some View {
        VStack() {
            HStack {
                ForEach(children) { child in
                    Button(action: {
                        onChildSelected(child)
                    }, label: {
                        ChildChipView(child: child, isSelected: selectedChild?.id == child.id)
                    })
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom)

            if let selectedChild = selectedChild,
               let selectedChildData = selectedChildData {
                ChildStatusView(child: selectedChild, childData: selectedChildData)
            }            
        }
    }
}

private extension StatusView {
    var selectedChildData: ChildData? {
        guard let selectedChild = selectedChild else {
            return nil
        }
        return childrenData.first { childData in
            childData.childId == selectedChild.id
        }
    }
}

#Preview {
    let childrenManager = MockChildrenManager()
    return HomeView()
        .environmentObject(HomeViewModel(childrenManager: childrenManager))
        .environmentObject(MapViewModel())
}
