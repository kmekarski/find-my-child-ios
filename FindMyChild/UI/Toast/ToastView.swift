//
//  ToastView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 25/06/2024.
//

import SwiftUI



struct ToastView: View {
    
    var style: ToastStyle
    var message: String
    var width = CGFloat.infinity
    var onCancelTapped: (() -> Void)
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image(systemName: style.iconFileName)
                .foregroundColor(style.themeColor)
            Text(message)
                .customFont()
                .foregroundColor(.onPrimaryContainer)
            
            Spacer(minLength: 10)
            
            Button {
                onCancelTapped()
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(.onPrimaryContainer)
            }
        }
        .padding()
        .frame(minWidth: 0, maxWidth: width)
        .background(.surface)
        .cornerRadius(8)
        .padding(.horizontal, 16)
    }
}

#Preview {
    VStack {
        ToastView(style: .error, message: "Error", onCancelTapped: {})
        ToastView(style: .warning, message: "Warning", onCancelTapped: {})
        ToastView(style: .info, message: "Info", onCancelTapped: {})
        ToastView(style: .success, message: "Success", onCancelTapped: {})
    }
}

enum ToastStyle {
    case error
    case warning
    case success
    case info
}

extension ToastStyle {
    var themeColor: Color {
        switch self {
        case .error: return Color.red
        case .warning: return Color.orange
        case .info: return Color.blue
        case .success: return Color.green
        }
    }
    
    var iconFileName: String {
        switch self {
        case .info: return "info.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .success: return "checkmark.circle.fill"
        case .error: return "xmark.circle.fill"
        }
    }
}
