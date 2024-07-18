//
//  SettingsListRowView.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 18/07/2024.
//

import SwiftUI

enum SettingsRowType {
    case regular
    case centered
}

struct SettingsRowData: Identifiable {
    let id: String
    let title: String
    let iconName: String?
    let action: () -> ()
    let type: SettingsRowType

    
    init(title: String, iconName: String?, type: SettingsRowType = .regular, action: @escaping () -> Void) {
        self.id = UUID().uuidString
        self.title = title
        self.iconName = iconName
        self.action = action
        self.type = type
    }
}

struct SettingsListRowView: View {
    var data: SettingsRowData
    
    var body: some View {
        Button(action: data.action, label: {
            if data.type == .centered {
                Text(data.title)
                    .customFont(.regular)
                    .modifier(SettingsListRowModifier())
            }
            else {
                HStack {
                    if let icon = data.iconName {
                        Image(systemName: icon)
                            .foregroundStyle(.primaryText)
                            .padding(.trailing, 8)
                    }
                    Text(data.title)
                        .customFont(.regular)
                        .foregroundStyle(.primaryText)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.accent)
                }
                .modifier(SettingsListRowModifier())
            }
        })

    }
}

#Preview {
    let settingsRowsData = [
        SettingsRowData(title: "Change password", iconName: "lock.fill") {},
        SettingsRowData(title: "Change password", iconName: "lock.fill") {},
        SettingsRowData(title: "Change password", iconName: "lock.fill") {},
    ]
    let centeredRowData = SettingsRowData(title: "Logout", iconName: nil, type: .centered) {}
    return VStack {
        SettingsListView(rowsData: settingsRowsData)
            .padding(.bottom)
        SettingsListRowView(data: centeredRowData)
    }
        .padding()
}

fileprivate struct SettingsListRowModifier: ViewModifier {
    func body(content: Content) -> some View {
            return content
            .frame(maxWidth: .infinity)
            .padding(20)
            .background(.surface)
            .clipShape(.rect(cornerRadius: 12))
    }
}
