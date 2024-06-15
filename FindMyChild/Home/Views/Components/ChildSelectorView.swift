//
//  ChildSelectorView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 15/06/2024.
//

import SwiftUI

struct ChildSelectorView: View {
    var children: [Child]
    var childrenData: [ChildData]
    @Binding var selectedChild: Child?
    var onChildSelected: (Child) -> ()
    var body: some View {
        HStack {
            ForEach(children) { child in
                Button(action: {
                    onChildSelected(child)
                }, label: {
                    ChildChipView(child: child, isSelected: selectedChild?.id == child.id)
                })
            }
        }
    }
}

#Preview {
    ChildSelectorView(
        children: MockData.children,
        childrenData: MockData.childrenData,
        selectedChild: .constant(MockData.children[0]),
               onChildSelected: {_ in}
    )
}
