//
//  SettingsView.swift
//  ColorThemes
//
//  Created by Uhl Albert on 5/7/24.
//

import SwiftUI

struct SettingsView: View {
    @Environment(ThemeManager.self) private var themeManager: ThemeManager
    @State private var searchText = ""
    @State private var showingSheet = false
    @State private var isEnabled = true

    private var settings: [Setting] {
        Setting.createSettings(theme: themeManager.theme)
    }

    var body: some View {
        NavigationStack {
            List {
                ProfileView()

                Section {
                    ForEach(settings.prefix(6), id: \.self) { setting in
                        SettingCell(setting: setting)
                    }
                }
                .listRowBackground(themeManager.theme.color(for: .primaryInteractive02))

                Section {
                    ForEach(settings.suffix(4), id: \.self) { setting in
                        SettingCell(setting: setting)
                    }
                }
                .listRowBackground(themeManager.theme.color(for: .primaryInteractive02))
            }
            .background(themeManager.theme.color(for: .primaryUi04))
            .toolbarBackground(themeManager.theme.color(for: .primaryInteractive01Hover), for: .navigationBar)
            .navigationTitle("Settings")
            .toolbar {
                HStack(spacing: 0) {
                    Button("\(themeManager.selectedTheme.rawValue)") {
                        showingSheet.toggle()
                    }
                    .sheet(isPresented: $showingSheet) {
                        ThemesView()
                            .presentationDetents([.medium, .large])
                    }
                }
            }
            .padding(.horizontal, -4)
        }
        .searchable(text: $searchText)
    }
}

struct ProfileView: View {
    @Environment(ThemeManager.self) private var themeManager: ThemeManager

    var body: some View {
        Section(header: Spacer().frame(height: 0)) {
            NavigationLink(destination: Text("Destination for Pat Smith")) {
                HStack {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .foregroundStyle(themeManager.theme.color(for: .iOSGray))
                        .frame(width: 60, height: 60)
                    VStack(alignment: .leading) {
                        Text("Pat Smith")
                            .font(.title2)
                            .foregroundStyle(themeManager.theme.color(for: .primaryText01))
                        Text("Apple ID, iCloud, Media & Purchases")
                            .font(.custom(
                                "SF Pro",
                                size: 14,
                                relativeTo: .subheadline
                            ))
                            .fontWeight(.ultraLight)
                            .foregroundStyle(themeManager.theme.color(for: .primaryText01))
                    }
                }
            }

            NavigationLink(destination: Text("Destination for Family")) {
                HStack {
                    HStack(spacing: -10) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(themeManager.theme.color(for: .iOSGray))
                            .frame(width: 35, height: 30)
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(themeManager.theme.color(for: .iOSGray))
                            .frame(width: 35, height: 30)
                    }
                    VStack(alignment: .leading) {
                        Text("Family")
                            .foregroundStyle(themeManager.theme.color(for: .primaryText01))
                    }
                }
            }
        }
        .listRowBackground(themeManager.theme.color(for: .primaryInteractive02))
    }
}

struct SettingCell: View {
    @Environment(ThemeManager.self) private var themeManager: ThemeManager

    let setting: Setting
    @State private var isOn: Bool = false

    var body: some View {
        if setting.isToggle {
            Toggle(isOn: $isOn) {
                HStack(spacing: 15) {
                    settingIcon
                }
            }
            .tint(themeManager.theme.color(for: .primaryInteractive01))
        } else if let destinationID = setting.destinationID {
            NavigationLink(destination: destinationView(for: destinationID)) {
                HStack(spacing: 15) {
                    settingIcon
                }
            }
        } else {
            HStack(spacing: 15) {
                settingIcon
            }
        }
    }

    private func destinationView(for id: DestinationID) -> some View {
        switch id {
        case .bluetooth:
            return AnyView(BluetoothSettingView())
        case .wifi:
            return AnyView(Text("Wi-Fi Settings"))
        case .cellular:
            return AnyView(Text("Cellular Settings"))
        case .notifications:
            return AnyView(Text("Notifications Settings"))
        case .custom(let customID):
            return AnyView(Text("Custom Destination: \(customID)"))
        }
    }

    @ViewBuilder
    private var settingIcon: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(setting.color)
            .frame(width: 30, height: 30)
            .overlay(
                Image(systemName: setting.iconName)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.white)
                    .frame(width: 20, height: 20)
            )

        Text(setting.text)
            .foregroundStyle(themeManager.theme.color(for: .primaryText01))

        Spacer()

        if let detailText = setting.detailText {
            Text(detailText)
                .foregroundStyle(.primary)
                .fontWeight(.light)
                .foregroundStyle(themeManager.theme.color(for: .primaryText01))
        }
    }
}

#Preview {
    SettingsView()
        .environment(ThemeManager())
}
