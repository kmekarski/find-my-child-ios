//
//  Color.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 14/06/2024.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorScheme()
}

struct ColorScheme {
    let primaryColor = Color("PrimaryColor")
    let primaryContainer = Color("PrimaryContainerColor")
    let onPrimary = Color("OnPrimaryColor")
    let onPrimaryContainer = Color("OnPrimaryContainerColor")
    let secondaryColor = Color("SecondaryColor")
    let secondaryContainer = Color("SecondaryContainerColor")
    let onSecondary = Color("OnSecondaryColor")
    let onSecondaryContainer = Color("OnSecondaryContainerColor")
}
