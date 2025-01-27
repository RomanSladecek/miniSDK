//
//  MiniSDK.swift
//  miniSDK
//
//  Created by Roman Sladecek on 24/01/2025.
//

import SwiftUI

public class MiniSDK {
    public static let shared = MiniSDK()
    private var apiEndpoint: String?

    private init() {}

    // Initialize the SDK with the API endpoint
    public func initialize(apiEndpoint: String) {
        self.apiEndpoint = apiEndpoint
    }

    // Get the form view
    public func getFormView() -> some View {
        guard let apiEndpoint = apiEndpoint else {
            return AnyView(Text("SDK not initialized. Call `initialize()` first."))
        }
        return AnyView(FormScreen(apiEndpoint: apiEndpoint))
    }
}
