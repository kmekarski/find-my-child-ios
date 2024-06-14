//
//  Int.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 14/06/2024.
//

import Foundation

extension Int {
    func asDistanceAwayString() -> String {
            if self <= 0 {
                return String(localized: "here_string")
            } else if self < 1000 {
                return "\(self)" + " " + String(localized: "meters_string") + " " + String(localized: "away_string")
            } else {
                let kilometers = Double(self) / 1000.0
                return String(format: "%.1f", kilometers) + " " + String(localized: "kilometers_string") + " " + String(localized: "away_string")
            }
        }
}
