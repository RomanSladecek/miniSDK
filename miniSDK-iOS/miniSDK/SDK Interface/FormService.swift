//
//  FormService.swift
//  miniSDK
//
//  Created by Roman Sladecek on 24/01/2025.
//

import Foundation

internal class FormService {
    static func fetchFormConfiguration(apiEndpoint: String) async throws -> FormConfiguration {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 2 * 1_000_000_000)
        
        // Simulate API request
        let simulatedJSON = """
        {
            "title": "miniSDK Form",
            "fields": [
                { "id": "\(UUID())", "label": "First name", "placeholder": "Enter your first name", "isRequired": true, "keyboardType": "default" },
                { "id": "\(UUID())", "label": "Last name", "placeholder": "Enter your last name", "isRequired": true, "keyboardType": "default" },
                { "id": "\(UUID())", "label": "Address", "placeholder": "Enter your address", "isRequired": false, "keyboardType": "default" },
                { "id": "\(UUID())", "label": "Email", "placeholder": "Enter your email", "isRequired": false, "keyboardType": "emailAddress" },
                { "id": "\(UUID())", "label": "Phone number", "placeholder": "Enter your phone number", "isRequired": false, "keyboardType": "phonePad" }
            ],
            "submitButtonText": "Submit",
            "fontSize": 16.0,
            "fontColor": "#000000",
            "backgroundColor": "#FFFFFF",
            "backgroundImage": "https://img.freepik.com/free-vector/blur-pink-blue-abstract-gradient-background-vector_53876-174836.jpg"
        }
        """.data(using: .utf8)!

        let formConfig = try JSONDecoder().decode(FormConfiguration.self, from: simulatedJSON)

        // Validate field count (1-5 fields)
        let fieldCount = formConfig.fields.count
        guard fieldCount >= 1 && fieldCount <= 5 else {
            throw NSError(domain: "com.minisdk.form", code: 400, userInfo: [NSLocalizedDescriptionKey: "The form must contain between 1 and 5 fields. Received \(fieldCount)."])
        }

        return formConfig
    }

    static func submitFormData(apiEndpoint: String, formData: [UUID: String]) async throws {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 2 * 1_000_000_000)

        // Simulate success or failure
        let isSuccess = Bool.random()
        if !isSuccess {
            throw NSError(domain: "com.minisdk.form", code: 500, userInfo: [NSLocalizedDescriptionKey: "Submission failed."])
        }
    }
}
