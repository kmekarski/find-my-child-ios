//
//  AuthError.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 13/07/2024.
//

import Foundation

protocol AuthError: Error {
    var message: String { get }
}
