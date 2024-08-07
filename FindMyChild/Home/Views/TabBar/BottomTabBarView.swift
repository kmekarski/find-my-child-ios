//
//  BottomTabBarView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 15/06/2024.
//

import SwiftUI

extension HomeViewTab {
    var text: String {
        switch self {
        case .status:
            return String(localized: "status_string")
        case .history:
            return String(localized: "history_string")
        }
    }
    
    var icon: String {
        switch self {
        case .status:
            return "person"
        case .history:
            return "clock"
        }
    }
}

struct BottomTabBarView: View {
    @Binding var selectedItem: HomeViewTab
    var body: some View {
        HStack {
            ForEach(HomeViewTab.allCases, id: \.self) { item in
                BottomTabBarItemView(item: item, isSelected: item == selectedItem)
                    .onTapGesture {
                        withAnimation {
                            selectedItem = item
                        }
                    }
            }
        }
        .padding(.horizontal, 32)
        .padding(.bottom)
    }
}

private extension BottomTabBarView {
    func itemWidth(geometry: GeometryProxy) -> CGFloat {
        return geometry.size.width/CGFloat(HomeViewTab.allCases.count)
    }
}

struct BottomTabBarItemView: View {
    var item: HomeViewTab
    var isSelected: Bool
    var body: some View {
        HStack {
            Image(systemName: item.icon)
            Text(item.text)
        }
        .fontWeight(.semibold)
        .padding(8)
        .foregroundStyle(isSelected ? .prim : .second)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    let childrenManager = MockChildrenManager()
    return VStack{
        BottomContentView(selectedItem: .status)
            .padding(.bottom)
        BottomTabBarView(selectedItem: .constant(.status))
    }
    .environmentObject(MapViewModel())
    .environmentObject(HomeViewModel(childrenManager: childrenManager))
}
