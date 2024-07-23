//
//  ParentOnboardingView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 23/07/2024.
//

import SwiftUI

struct ParentOnboardingView: View {
    @EnvironmentObject var vm: ParentOnboardingViewModel
    var body: some View {
        VStack {
            Text("parent onboarding")
            Button("finish onboarding") {
                finishOnboarding()
            }
            Button("show error") {
                vm.showError()
            }
        }
            .toastView(toast: $vm.toast)
    }
}

#Preview {
    let userManager = MockUserManager()
    let authManager = MockAuthManager()
    return ParentOnboardingView()
        .environmentObject(ParentOnboardingViewModel(userManager: userManager, authManager: authManager))
}

extension ParentOnboardingView {
    private func finishOnboarding() {
        Task {
            await vm.finishOnboarding()
        }
    }
}
