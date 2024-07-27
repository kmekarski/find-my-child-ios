//
//  ParentOnboardingView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 23/07/2024.
//

import SwiftUI

enum ParentOnboardingStep: Int, CaseIterable {
    case smsVerification
    case addChildren
    case addProfilePicture
}

struct ParentOnboardingView: View {
    @EnvironmentObject var vm: ParentOnboardingViewModel
    var body: some View {
        VStack {
            SegmentedProgressBarView(numberOfSegments: ParentOnboardingStep.allCases.count, currentSegmentIndex: step.rawValue)
                .padding(.bottom)
            switch step {
            case .smsVerification:
                ParentOnboardingSmsVerificationView()
            case .addChildren:
                ParentOnboardingAddChildrenView()
            case .addProfilePicture:
                ParentOnboardingAddProfilePictureView()
            }
            Spacer()
        }
        .padding()
        .toastView(toast: $vm.toast)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    let userManager = MockUserManager()
    let authManager = MockAuthManager()
    return ParentOnboardingView()
        .environmentObject(ParentOnboardingViewModel(userManager: userManager, authManager: authManager))
        .environmentObject(AuthViewModel(authManager: authManager))
}

private extension ParentOnboardingView {
    var step: ParentOnboardingStep {
        vm.step
    }
    
    var isFirstStep: Bool {
        vm.isFirstStep
    }
    
    var isLastStep: Bool {
        vm.isLastStep
    }
    
    func finishOnboarding() {
        Task {
            await vm.finishOnboarding()
        }
    }
}
