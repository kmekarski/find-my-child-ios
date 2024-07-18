//
//  SettingsListRowView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 18/07/2024.
//

import SwiftUI

struct SettingsRowData: Identifiable {
    let id: String
    let title: String
    let iconName: String?
    let action: () -> ()
    
    init(title: String, iconName: String?, action: @escaping () -> Void) {
        self.id = UUID().uuidString
        self.title = title
        self.iconName = iconName
        self.action = action
    }
}

struct SettingsListRowView: View {
    var data: SettingsRowData
    
    var body: some View {
        Button(action: data.action, label: {
            HStack {
                if let icon = data.iconName {
                    Image(systemName: icon)
                        .padding(.trailing, 8)
                }
                Text(data.title)
                    .customFont(.regular)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(.accent)
            }
            .padding(.vertical, 20)
            .padding(.horizontal)
            .background(.surface)
            .clipShape(.rect(cornerRadius: 12))
        })

    }
}

#Preview {
    let settingsRowsData = [
        SettingsRowData(title: "Change password", iconName: "lock.fill") {},
        SettingsRowData(title: "Change password", iconName: "lock.fill") {},
        SettingsRowData(title: "Change password", iconName: "lock.fill") {},
    ]
    return SettingsListView(rowsData: settingsRowsData)
}
