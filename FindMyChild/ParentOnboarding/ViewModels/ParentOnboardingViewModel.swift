//
//  ParentOnboardingViewModel.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 23/07/2024.
//

import Foundation

class ParentOnboardingViewModel: ObservableObject {
    var userManager: UserManagerProtocol
    var authManager: AuthManagerProtocol
    
    @Published var step: ParentOnboardingStep = .smsVerification
    @Published var toast: Toast?
    
    init(userManager: UserManagerProtocol, authManager: AuthManagerProtocol) {
        self.userManager = userManager
        self.authManager = authManager
    }
    
    func finishOnboarding() async {
        guard let user = authManager.currentUser else { return }
        do {
            try await userManager.finishParentOnboarding(userId: user.id)
            await authManager.checkAuthentication()
        } catch {
            toast = Toast(style: .error, message: "Something went wrong")
        }
    }
    
    func showError() {
        toast = Toast(style: .error, message: "Something went wrong")
    }
    
    func goToNextStep() {
        if !isLastStep {
            step = ParentOnboardingStep(rawValue: step.rawValue + 1) ?? .smsVerification
        }
    }
    
    func goToPreviousStep() {
        if !isFirstStep {
            step = ParentOnboardingStep(rawValue: step.rawValue - 1) ?? .smsVerification
        }
    }
    
    var isLastStep: Bool {
        return step.rawValue + 1 >= ParentOnboardingStep.allCases.count
    }
    
    var isFirstStep: Bool {
        return step.rawValue == 0
    }
}
