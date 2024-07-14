//
//  HomeHeaderView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 14/07/2024.
//

import SwiftUI

protocol HomeHeaderProtocol: View {
    
}

struct HomeHeaderTemplateView<Header: HomeHeaderProtocol>: View {
    var header: Header
    var body: some View {
        HStack {
            header
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
    return HomeHeaderTemplateView(header: MapHeaderView())
        .environmentObject(HomeViewModel(childrenManager: childrenManager))
        .environmentObject(AuthViewModel(authManager: authManager))
        .environmentObject(MapViewModel())
}
