//
//  Untitled.swift
//  miniSDK
//
//  Created by Roman Sladecek on 25/01/2025.
//

import Foundation
import SwiftUI

@objc class MiniSDKHandler: NSObject {
    @objc static func initializeSDK(apiEndpoint: String) {
        MiniSDK.shared.initialize(apiEndpoint: apiEndpoint)
    }

    @objc static func getFormViewController() -> UIViewController {
        // Return a SwiftUI `FormScreen` as a UIViewController
        let formView = MiniSDK.shared.getFormView()
        return UIHostingController(rootView: formView)
    }
}
