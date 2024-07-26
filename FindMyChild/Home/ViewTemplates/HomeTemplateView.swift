//
//  HomeTemplateView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 14/07/2024.
//

import SwiftUI

protocol HomeScreenProtocol: View {
    var type: AppRoute { get }
}

struct HomeTemplateView<Screen: HomeScreenProtocol, Header: HomeHeaderProtocol>: View {
    var screen: Screen
    var header: Header
    var body: some View {
        return switch screen.type {
        case .map: AnyView(ZStack {
            screen
            VStack {
                header
                Spacer()
            }
        }
            .navigationBarBackButtonHidden())
        default: AnyView(VStack {
            header
            screen
                .frame(maxHeight: .infinity)
                .padding()
        }
            .navigationBarBackButtonHidden())
        }
    }
}

#Preview {
    let childrenManager = MockChildrenManager()
    let authManager = MockAuthManager()
    return HomeTemplateView(screen: HomeView(), header: MapHeaderView())
        .environmentObject(HomeViewModel(childrenManager: childrenManager))
        .environmentObject(AuthViewModel(authManager: authManager))
        .environmentObject(MapViewModel())
}
