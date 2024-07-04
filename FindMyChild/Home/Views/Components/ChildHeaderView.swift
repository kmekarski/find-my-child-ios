//
//  ChildHeaderView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 22/06/2024.
//

import SwiftUI

struct ChildHeaderView: View {
    @EnvironmentObject var homeVM: HomeViewModel
    var body: some View {
        HStack {
            if let selectedChild = homeVM.selectedChild {
                Text(selectedChild.name)
                    .customFont(.bold, 20)
                Spacer()
                batteryIcon
                phoneButton
            }
        }
    }
}

#Preview {
    let childrenManager = MockChildrenManager()
    return ChildHeaderView()
        .environmentObject(HomeViewModel(childrenManager: childrenManager))
}

extension ChildHeaderView {
    var batteryIconName: String {
        guard let batteryLevel = homeVM.selectedChildData?.batteryLevel else {
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
            if homeVM.selectedChildData?.batteryLevel == nil {
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
