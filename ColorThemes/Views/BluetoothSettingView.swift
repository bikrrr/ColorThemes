//
//  BluetoothSettingView.swift
//  ColorThemes
//
//  Created by Uhl Albert on 11/5/24.
//

import SwiftUI

struct BluetoothSettingView: View {
    @State private var isEnabled = true

    var body: some View {
        NavigationStack {
            List {
                Section {
                    Toggle("Start PiP Automatically", isOn: $isEnabled)
                } footer: {
                    Text("When you swipe up to go Home or use other apps, videos and FaceTime calls will automatically continue in Picture in Picture.")
                        .padding(.top, 4)
                }
            }
        }
    }
}

#Preview {
    BluetoothSettingView()
}
