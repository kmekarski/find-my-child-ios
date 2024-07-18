//
//  CircleProfileImageView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 17/07/2024.
//

import SwiftUI

enum CircleProfileImageSize: CGFloat {
    case small = 48
    case large = 128
    
    var borderSize: CGFloat {
        return switch self {
        case .small: 3
        case .large: 5
        }
    }
}

struct CircleProfileImageView: View {
    var url: URL?
    var size: CircleProfileImageSize = .small
    var body: some View {
        AsyncImage(url: url){ image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Image(systemName: "person.fill")
                        .font(.system(size: size.rawValue*0.35))
                }
                .frame(width: size.rawValue, height: size.rawValue)
                .background(.surface)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.white, lineWidth: size.borderSize)
                        .frame(width: size.rawValue, height: size.rawValue)
                )
                .customShadow(.subtleDownShadow)
    }
}

#Preview {
    let url = URL(string: "https://fastly.picsum.photos/id/1024/200/200.jpg?hmac=LR-PJPi70YREc_0NdDp68FkLt6-f1sKeJWwgOhCeyBU")
    return ZStack {
        HStack {
            CircleProfileImageView(url: url, size: .large)
            CircleProfileImageView(size: .large)
            CircleProfileImageView(url: url, size: .small)
            CircleProfileImageView(size: .small)
        }
    }
}
