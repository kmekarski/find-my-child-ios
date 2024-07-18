//
//  SettingsListView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 18/07/2024.
//

import SwiftUI

struct SettingsListView: View {
    var title: String?
    var rowsData: [SettingsRowData]
    
    var body: some View {
        
        VStack {
            if let title = title, title != "" {
                Text(title)
                    .customFont(.regular,20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 12)
            }
            VStack(spacing: 12) {
                ForEach(rowsData) { rowData in
                    SettingsListRowView(data: rowData)
                }
            }
        }
    }
}
#Preview {
    let rowsData = [
        SettingsRowData(title: "Change password", iconName: "lock.fill") {},
        SettingsRowData(title: "Change password", iconName: "lock.fill") {},
        SettingsRowData(title: "Change password", iconName: "lock.fill") {},
    ]
    return SettingsListView(title: "Profile settings", rowsData: rowsData)
        .padding()
}
