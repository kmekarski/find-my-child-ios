//
//  HomeHeaderView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 14/07/2024.
//

import SwiftUI

protocol HomeHeaderProtocol: View {
    var title: String? { get }
}

struct HomeHeaderData {
    var title: String?
    var leftItems: [AnyView]?
    var rightItems: [AnyView]?
    var isTitleCentered: Bool
    
    init(title: String? = nil, leftItems: [Any] = [], rightItems: [Any] = [], isTitleCentered: Bool = false) {
        self.title = title
        self.leftItems = leftItems.compactMap({ item in
            (item as? (any View)) != nil ? AnyView((item as! (any View))) : nil
        })
        self.rightItems = rightItems.compactMap({ item in
            (item as? (any View)) != nil ? AnyView((item as! (any View))) : nil
        })
        self.isTitleCentered = isTitleCentered
    }
}

struct HomeHeaderTemplateView: View {
    var data: HomeHeaderData
    var body: some View {
        ZStack {
            HStack {
                if let leftItems = data.leftItems {
                    sideItems(leftItems)
                }
                if !data.isTitleCentered, let title = data.title {
                    titleView(title)
                        .padding(.leading, 8)
                }
                Spacer()
                if let rightItems = data.rightItems {
                    sideItems(rightItems)
                }
            }
            if data.isTitleCentered, let title = data.title {
                titleView(title)
            }
        }
        .padding(.horizontal)
        .padding(.bottom)
        .frame(maxWidth: .infinity)
        .background(Material.thick)
        .padding(.bottom, 4)
    }
}

#Preview {
    let childrenManager = MockChildrenManager()
    let authManager = MockAuthManager()
    return HomeTemplateView(screen: ProfileView(), header: ProfileHeaderView())
        .environmentObject(HomeViewModel(childrenManager: childrenManager))
        .environmentObject(AuthViewModel(authManager: authManager))
        .environmentObject(MapViewModel())
        .environmentObject(HomeNavigationViewModel())
}

extension HomeHeaderTemplateView {
    func titleView(_ text: String) -> some View {
        return Text(text)
            .customFont(.regular, 22)
    }
    
    func sideItems(_ items: [AnyView]) -> some View {
        HStack(spacing: 16) {
            ForEach(items.indices, id: \.self) { index in
                items[index]
            }
        }
    }
}
