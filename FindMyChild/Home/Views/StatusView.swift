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
                
                Spacer()
                
                if let selectedChildData = selectedChildData {
                    batteryIcon
                    phoneButton
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
    
    var batteryIconName: String {
        guard let batteryLevel = selectedChildData?.batteryLevel else {
            return "battery.0percent"
        }
        switch batteryLevel {
        case 76...100:
            return "battery.100percent"
        case 51...75:
            return "battery.75percent"
        case 26...50:
            return "battery.25percent"
        case 0...25:
            return "battery.0percent"
        default:
            return ""
        }
    }
    
    var batteryIcon: some View {
        ZStack {
            Image(systemName: batteryIconName)
                .font(.system(size: 22, weight: .semibold))
            if selectedChildData?.batteryLevel == nil {
                Image(systemName: "questionmark")
                    .font(.system(size: 18, weight: .semibold))
                    .background() {
                        VStack(spacing: 0){
                            Rectangle()
                                .frame(width: 16, height: 10)
                            Rectangle()
                                .frame(width: 8, height: 10)
                        }
                        .foregroundStyle(.white)
                    }
                    .offset(x: -1)
            }
        }
        .foregroundStyle(.prim)
    }
    
    var phoneButton: some View {
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
            Image(systemName: "phone")
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(.prim)
        })
    }
}

#Preview {
    let childrenManager = MockChildrenManager()
    return HomeView()
        .environmentObject(HomeViewModel(childrenManager: childrenManager))
        .environmentObject(MapViewModel())
}
