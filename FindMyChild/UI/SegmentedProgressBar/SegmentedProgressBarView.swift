//
//  SegmentedProgressBarView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 26/07/2024.
//

import SwiftUI

struct SegmentedProgressBarView: View {
    var numberOfSegments: Int
    var currentSegmentIndex: Int
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<numberOfSegments, id: \.self) { index in
                RoundedRectangle(cornerRadius: 4)
                    .frame(height: 8)
                    .foregroundStyle(index <= currentSegmentIndex ? .prim : .second)
            }
        }
    }
}


#Preview {
    SegmentedProgressBarView(numberOfSegments: 4, currentSegmentIndex: 1)
        .padding()
}
