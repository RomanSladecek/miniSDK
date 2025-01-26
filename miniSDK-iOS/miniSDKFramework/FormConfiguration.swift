//
//  FormConfiguration.swift
//  miniSDK
//
//  Created by Roman Sladecek on 24/01/2025.
//

import Foundation

public struct FormConfiguration: Decodable {
    public let fields: [FormField]
    public let submitButtonText: String
    public let fontSize: Double?
    public let fontColor: String?
    public let backgroundColor: String? // Color HEX code
    public let backgroundImage: String? // URL of the background image
}
