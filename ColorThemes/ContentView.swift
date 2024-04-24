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
                                    .font(.subheadline)
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

                Section {
                    ForEach(Setting.allCases.prefix(6), id: \.self) { setting in
                        SettingCell(setting: setting)
                    }
                }

                Section {
                    ForEach(Setting.allCases.suffix(4), id: \.self) { setting in
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

class SettingCellViewModel: ObservableObject {
    @Published var isOn: Bool

    init(setting: Setting) {
        switch setting {
            case .airplaneMode, .vpn:
                isOn = false // Set the initial state for toggles
            default:
                isOn = false // You can set a default state or handle it differently
        }
    }
}

struct SettingCell: View {
    let setting: Setting
    @ObservedObject private var viewModel: SettingCellViewModel

    init(setting: Setting) {
        self.setting = setting
        self.viewModel = SettingCellViewModel(setting: setting)
    }

    var body: some View {
        // Check if the option should display a toggle
        if setting == .airplaneMode || setting == .vpn {
            Toggle(isOn: $viewModel.isOn) {
                HStack(spacing: 15) {
                    settingIcon
                }
            }
        } else {
            // Use a NavigationLink for other options
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

enum Setting: CaseIterable {
    case airplaneMode, wifi, bluetooth, cellular, personalHotspot, vpn, notifications, soundsHaptics, focus, screenTime

    var iconName: String {
        switch self {
            case .airplaneMode: return "airplane"
            case .wifi: return "wifi"
            case .bluetooth: return "dot.radiowaves.right"
            case .cellular: return "antenna.radiowaves.left.and.right"
            case .personalHotspot: return "personalhotspot"
            case .vpn: return "network"
            case .notifications: return "bell.badge.fill"
            case .soundsHaptics: return "speaker.wave.3.fill"
            case .focus: return "moon.fill"
            case .screenTime: return "hourglass"
        }
    }

    var text: String {
        switch self {
            case .airplaneMode: return "Airplane Mode"
            case .wifi: return "Wi-Fi"
            case .bluetooth: return "Bluetooth"
            case .cellular: return "Cellular"
            case .personalHotspot: return "Personal Hotspot"
            case .vpn: return "VPN"
            case .notifications: return "Notifications"
            case .soundsHaptics: return "Sounds & Haptics"
            case .focus: return "Focus"
            case .screenTime: return "Screen Time"
        }
    }

    var color: Color {
        switch self {
            case .airplaneMode: return .orange
            case .wifi: return .blue
            case .bluetooth: return .blue
            case .cellular, .personalHotspot: return .green
            case .vpn: return .blue
            case .notifications, .soundsHaptics: return .red
            case .focus, .screenTime: return .indigo
        }
    }

    var detailText: String? {
        switch self {
            case .wifi: return "FBISurveillanceVan"
            case .bluetooth: return "On"
            case .personalHotspot: return "Off"
            default: return nil
        }
    }
}

#Preview {
    ContentView()
}
