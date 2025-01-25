//
//  miniSDKApp.swift
//  miniSDK
//
//  Created by Roman Sladecek on 24/01/2025.
//

import SwiftUI

@main
struct ClientApp: App {
    init() {
        // Initialize the SDK with the API endpoint
        MiniSDK.shared.initialize(apiEndpoint: "https://api.example.com/form")
    }

    var body: some Scene {
        WindowGroup {
            ScreenView()
        }
    }
}
