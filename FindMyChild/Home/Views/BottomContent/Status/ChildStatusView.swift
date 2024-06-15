//
//  ChildStatusView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 14/06/2024.
//

import SwiftUI

struct ChildStatusView: View {
    var child: Child
    var childData: ChildData
    var body: some View {
        HStack {
            Image(systemName: "person")
                .frame(width: 56, height: 56)
                .foregroundStyle(.onPrimary)
                .background()
                .backgroundStyle(.accent)
                .clipShape(.circle)
                .padding(.trailing, 8)
            VStack(alignment: .leading) {
                Text(locationString)
                    .customFont(.bold, 18)
                    .lineLimit(2)
                Text(distanceString)
                    .customFont(.light)
                    .padding(.bottom, 4)
                Text(lastTimeSeenString)
                    .customFont(.regular)
                    .lineLimit(2)
            }
            .foregroundStyle(.onPrimaryContainer)            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private extension ChildStatusView {
    var locationString: String {
        return childData.locationDescription ?? String(localized: "unknown_location_string")
    }
    
    var distanceString: String {
        let valueString = childData.distance?.asDistanceAwayString() ?? String(localized: "distance_string") + ": " + String(localized: "unknown_string")
        return valueString
    }
    
    var lastTimeSeenString: String {
        let valueString = childData.updatedDate?.asTimeAgoString() ?? String(localized: "unknown_string")
        return String(localized: "last_time_seen_string") + ": " + valueString
    }
}

#Preview {
    let childrenManager = MockChildrenManager()
    return HomeView()
        .environmentObject(HomeViewModel(childrenManager: childrenManager))
        .environmentObject(MapViewModel())
}
