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
                .background()
                .backgroundStyle(.blue)
                .clipShape(.circle)
                .padding(.trailing, 8)
            VStack(alignment: .leading) {
                Text(locationString)
                Text(distanceString)
                Text(lastTimeSeenString)
            }
            Spacer()
            if childData.batteryLevel != nil {
                Image(systemName: batteryIconName)
            } else {
                batteryUnknownIcon
            }
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Image(systemName: "phone")
            })
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private extension ChildStatusView {
    var locationString: String {
        return childData.locationDescription ?? String(localized: "unknown_location_string")
    }
    
    var distanceString: String {
        let valueString = childData.distance?.asDistanceAwayString() ?? "Distance: " + String(localized: "unknown_string")
        return valueString
    }
    
    var lastTimeSeenString: String {
        let valueString = childData.updatedDate?.asTimeAgoString() ?? String(localized: "unknown_string")
        return String(localized: "last_time_seen_string") + ": " + valueString
    }
    
    var batteryIconName: String {
        guard let batteryLevel = childData.batteryLevel else {
            return ""
        }
        switch batteryLevel {
        case 76...100:
            return "battery.100percent"
        case 51...75:
            return "battery.75percent"
        case 26...50:
            return "battery.25percent"
        case 0...25:
            return "battery.0percent"
        default:
            return ""
        }
    }
    
    var batteryUnknownIcon: some View {
        ZStack {
            Image(systemName: "battery.0percent")
            Image(systemName: "questionmark")
                .background() {
                    VStack(spacing: 0){
                        Rectangle()
                            .frame(width: 14, height: 10)
                        Rectangle()
                            .frame(width: 7, height: 10)
                            .offset(x: -1)
                    }
                    .foregroundStyle(.white)
                }
                .offset(x: -1)
        }
    }
}

#Preview {
    let childrenManager = MockChildrenManager()
    return HomeView()
        .environmentObject(HomeViewModel(childrenManager: childrenManager))
        .environmentObject(MapViewModel())
}
