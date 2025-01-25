//
//  FormField.swift
//  miniSDK
//
//  Created by Roman Sladecek on 24/01/2025.
//

import Foundation

struct FormField: Identifiable, Decodable {
    let id: UUID
    let label: String
    let placeholder: String
    let isRequired: Bool
    let keyboardType: String?
}
