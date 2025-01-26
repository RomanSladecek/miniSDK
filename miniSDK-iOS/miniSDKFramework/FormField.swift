//
//  FormField.swift
//  miniSDK
//
//  Created by Roman Sladecek on 24/01/2025.
//

import Foundation

public struct FormField: Identifiable, Decodable {
    public let id: UUID
    public let label: String
    public let placeholder: String
    public let isRequired: Bool
    public let keyboardType: String?
}
