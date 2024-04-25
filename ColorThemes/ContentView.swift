//
//  ContentView.swift
//  ColorThemes
//
//  Created by Uhl Albert on 4/23/24.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            List {
                ProfileView()

                Section {
                    ForEach(Setting.allSettings.prefix(6), id: \.self) { setting in
                        SettingCell(setting: setting)
                    }
                }

                Section {
                    ForEach(Setting.allSettings.suffix(4), id: \.self) { setting in
                        SettingCell(setting: setting)
                    }
                }
            }
            .navigationTitle("Settings")
            .padding(.horizontal, -4)
        }
        .searchable(text: $searchText)
    }
}

struct ProfileView: View {
    var body: some View {
        Section(header: Spacer().frame(height: 0)) {
            NavigationLink(destination: Text("Destination for Pat Smith")) {
                HStack {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .foregroundStyle(.secondary)
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
                            .foregroundStyle(.gray)
                            .frame(width: 35, height: 30)
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.gray)
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

struct Setting: Identifiable, Equatable, Hashable {
    let id = UUID()
    let iconName: String
    let text: String
    let color: Color
    let detailText: String?
    let isToggle: Bool

    init(iconName: String, text: String, color: Color, detailText: String? = nil, isToggle: Bool = false) {
        self.iconName = iconName
        self.text = text
        self.color = color
        self.detailText = detailText
        self.isToggle = isToggle
    }

    static func == (lhs: Setting, rhs: Setting) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Setting {
    static let airplaneMode = Setting(
        iconName: "airplane",
        text: "Airplane Mode",
        color: .orange,
        detailText: nil,
        isToggle: true
    )

    static let wifi = Setting(
        iconName: "wifi",
        text: "Wi-Fi",
        color: .blue,
        detailText: "FBISurveillanceVan",
        isToggle: false
    )

    static let bluetooth = Setting(
        iconName: "dot.radiowaves.right",
        text: "Bluetooth",
        color: .blue,
        detailText: "On",
        isToggle: false
    )

    static let cellular = Setting(
        iconName: "antenna.radiowaves.left.and.right",
        text: "Cellular",
        color: .green,
        detailText: nil,
        isToggle: false
    )

    static let personalHotspot = Setting(
        iconName: "personalhotspot",
        text: "Personal Hotspot",
        color: .green,
        detailText: "Off",
        isToggle: false
    )

    static let vpn = Setting(
        iconName: "network",
        text: "VPN",
        color: .blue,
        detailText: nil,
        isToggle: true
    )

    static let notifications = Setting(
        iconName: "bell.badge.fill",
        text: "Notifications",
        color: .red,
        detailText: nil,
        isToggle: false
    )

    static let soundsHaptics = Setting(
        iconName: "speaker.wave.3.fill",
        text: "Sounds & Haptics",
        color: .red,
        detailText: nil,
        isToggle: false
    )

    static let focus = Setting(
        iconName: "moon.fill",
        text: "Focus",
        color: .indigo,
        detailText: nil,
        isToggle: false
    )

    static let screenTime = Setting(
        iconName: "hourglass",
        text: "Screen Time",
        color: .indigo,
        detailText: nil,
        isToggle: false
    )

    static let allSettings: [Setting] = [
        .airplaneMode,
        .wifi,
        .bluetooth,
        .cellular,
        .personalHotspot,
        .vpn,
        .notifications,
        .soundsHaptics,
        .focus,
        .screenTime
    ]
}

#Preview {
    ContentView()
}
