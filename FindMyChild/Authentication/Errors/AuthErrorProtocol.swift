//
//  AuthError.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 13/07/2024.
//

import Foundation

protocol AuthErrorProtocol: Error {
    var message: String { get }
}
