//
//  Toast.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 04/07/2024.
//

import Foundation

struct Toast: Equatable {
  var style: ToastStyle
  var message: String
  var duration: Double = 3
  var width: Double = .infinity
}
