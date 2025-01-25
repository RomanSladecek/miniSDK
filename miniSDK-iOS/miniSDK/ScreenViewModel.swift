//
//  FormViewModel.swift
//  miniSDK
//
//  Created by Roman Sladecek on 24/01/2025.
//

import Foundation
import SwiftUI

@MainActor
class ScreenViewModel: ObservableObject {
    @Published var formConfig: FormConfiguration?
    @Published var formData: [UUID: String] = [:]
    @Published var errorMessages: [UUID: String] = [:]
    @Published var isFetchingForm = false
    @Published var isSubmittingForm = false
    @Published var fetchError: String? // Error for form fetching
    @Published var submitError: String? // Error for form submission
    @Published var isSubmitSuccessful: Bool?

    private let apiEndpoint: String

    init(apiEndpoint: String) {
        self.apiEndpoint = apiEndpoint
    }

    func fetchFormConfiguration() async {
        isFetchingForm = true
        fetchError = nil
        defer { isFetchingForm = false }

        do {
            let formConfig = try await FormService.fetchFormConfiguration(apiEndpoint: apiEndpoint)
            self.formConfig = formConfig
            self.formData = Dictionary(uniqueKeysWithValues: formConfig.fields.map { ($0.id, "") })
        } catch {
            fetchError = "Failed to load form configuration: \(error.localizedDescription)"
        }
    }

    func submitForm() {
        guard let formConfig = formConfig else { return }

        errorMessages = [:]
        submitError = nil
        var hasErrors = false

        // Validate required fields
        for field in formConfig.fields where field.isRequired {
            if formData[field.id]?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
                errorMessages[field.id] = "This field is required."
                hasErrors = true
            }
        }

        if hasErrors {
            return
        }

        // Simulate API call
        isSubmittingForm = true
        Task {
            do {
                try await FormService.submitFormData(apiEndpoint: apiEndpoint, formData: formData)
                isSubmitSuccessful = true
            } catch {
                submitError = "Failed to submit the form: \(error.localizedDescription)"
            }
            isSubmittingForm = false
        }
    }
}
