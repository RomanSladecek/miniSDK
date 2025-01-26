//
//  ContentView.swift
//  miniSDK
//
//  Created by Roman Sladecek on 24/01/2025.
//

import SwiftUI
import miniSDKFramework

struct ScreenView: View {
    var body: some View {
        NavigationView {
            MiniSDK.shared.getFormView()
                .navigationTitle("iOS Form View")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
