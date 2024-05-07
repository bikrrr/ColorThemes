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

    private var settings: [Setting] {
        Setting.createSettings(theme: themeManager.theme)
    }

    var body: some View {
        @Bindable var themeManager = themeManager

        NavigationStack {
            List {
                ProfileView()

                Section {
                    ForEach(settings.prefix(6), id: \.self) { setting in
                        SettingCell(setting: setting)
                    }
                }

                Section {
                    ForEach(settings.suffix(4), id: \.self) { setting in
                        SettingCell(setting: setting)
                    }
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 0) {
                        Button("\(themeManager.selectedTheme.rawValue)") {
                            showingSheet.toggle()
                        }
                        .sheet(isPresented: $showingSheet) {
                            ThemesView()
                        }
                    }
                    .buttonStyle(.bordered)
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
                        Text("Apple ID, iCloud, Media & Purchases")
                            .font(.custom(
                                "SF Pro",
                                size: 14,
                                relativeTo: .subheadline))
                            .fontWeight(.ultraLight)
                            .foregroundStyle(.primary)
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
                            .foregroundStyle(.primary)
                    }
                }
            }
        }
    }
}

struct SettingCell: View {
    let setting: Setting
    @State private var isOn: Bool = false

    var body: some View {
        if setting.isToggle {
            Toggle(isOn: $isOn) {
                HStack(spacing: 15) {
                    settingIcon
                }
            }
        } else {
            NavigationLink(destination: Text("Destination for \(setting.text)")) {
                HStack(spacing: 15) {
                    settingIcon
                }
            }
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

        Spacer()

        if let detailText = setting.detailText {
            Text(detailText)
                .foregroundStyle(.primary)
                .fontWeight(.light)
        }
    }
}

#Preview {
    SettingsView()
        .environment(ThemeManager())
}

