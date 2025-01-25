//
//  FormConfiguration.swift
//  miniSDK
//
//  Created by Roman Sladecek on 24/01/2025.
//

import Foundation

struct FormConfiguration: Decodable {
    let title: String
    let fields: [FormField]
    let submitButtonText: String
    let fontSize: Double?
    let fontColor: String?
    let backgroundColor: String? // Color HEX code
    let backgroundImage: String? // URL of the background image
}
