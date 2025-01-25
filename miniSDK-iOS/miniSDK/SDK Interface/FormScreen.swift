//
//  FormScreen.swift
//  miniSDK
//
//  Created by Roman Sladecek on 24/01/2025.
//

import SwiftUI

struct FormScreen: View {
    @StateObject private var viewModel: ScreenViewModel

    init(apiEndpoint: String) {
        _viewModel = StateObject(wrappedValue: ScreenViewModel(apiEndpoint: apiEndpoint))
    }

    var body: some View {
        NavigationView {
            ZStack {
                // Background handling (image or color)
                if let backgroundImage = viewModel.formConfig?.backgroundImage,
                   let url = URL(string: backgroundImage) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .ignoresSafeArea()
                    } placeholder: {
                        Color(hex: viewModel.formConfig?.backgroundColor ?? "#FFFFFF")
                            .ignoresSafeArea()
                    }
                } else {
                    Color(hex: viewModel.formConfig?.backgroundColor ?? "#FFFFFF")
                        .ignoresSafeArea()
                }

                VStack {
                    if viewModel.isFetchingForm {
                        ProgressView("Loading...")
                            .progressViewStyle(CircularProgressViewStyle())
                    } else if let fetchError = viewModel.fetchError {
                        Text(fetchError)
                            .foregroundColor(.red)
                            .padding()
                        Button("Retry") {
                            Task {
                                await viewModel.fetchFormConfiguration()
                            }
                        }
                        .padding()
                    } else if let formConfig = viewModel.formConfig {
                        Form {
                            ForEach(formConfig.fields) { field in
                                VStack(alignment: .leading, spacing: 4) {
                                    HStack {
                                        Text(field.label)
                                            .font(.system(size: formConfig.fontSize ?? 16))
                                            .foregroundColor(Color(hex: formConfig.fontColor ?? "#333333"))
                                        if field.isRequired {
                                            Text("*")
                                                .font(.system(size: formConfig.fontSize ?? 16))
                                                .foregroundColor(.red)
                                        }
                                        Spacer()
                                    }

                                    let textBinding = Binding(
                                        get: { viewModel.formData[field.id] ?? "" },
                                        set: { viewModel.formData[field.id] = $0 }
                                    )

                                    TextField(field.placeholder, text: textBinding)
                                        .font(.system(size: formConfig.fontSize ?? 16))
                                        .foregroundColor(Color(hex: formConfig.fontColor ?? "#333333"))
                                        .padding(8)
                                        .background(Color.clear)
                                        .cornerRadius(8)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(
                                                    viewModel.errorMessages[field.id] != nil ? Color.red : Color.gray,
                                                    lineWidth: 1
                                                )
                                        )
                                        .keyboardType(keyboardType(from: field.keyboardType))

                                    if let errorMessage = viewModel.errorMessages[field.id] {
                                        Text(errorMessage)
                                            .font(.footnote)
                                            .foregroundColor(.red)
                                    }
                                }
                                .padding(.vertical, 4)
                            }

                            Button(action: {
                                viewModel.submitForm()
                            }) {
                                HStack {
                                    Text(formConfig.submitButtonText)
                                        .font(.system(size: formConfig.fontSize ?? 16))
                                        .foregroundColor(.white)
                                    if viewModel.isSubmittingForm {
                                        ProgressView()
                                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                            .scaleEffect(0.8)
                                    }
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(8)
                            }
                            .disabled(viewModel.isSubmittingForm)
                        }
                        .navigationTitle(formConfig.title)
                        .scrollContentBackground(.hidden)
                    }
                }
                .padding()

                if viewModel.isSubmittingForm {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(2.0)
                }
            }
            .task {
                await viewModel.fetchFormConfiguration()
            }
            .alert(isPresented: Binding(
                get: { viewModel.isSubmitSuccessful != nil || viewModel.submitError != nil },
                set: { _ in
                    viewModel.isSubmitSuccessful = nil
                    viewModel.submitError = nil
                }
            )) {
                if viewModel.isSubmitSuccessful == true {
                    return Alert(
                        title: Text("Success"),
                        message: Text("The form has been successfully submitted!"),
                        dismissButton: .default(Text("OK"))
                    )
                } else {
                    return Alert(
                        title: Text("Error"),
                        message: Text(viewModel.submitError ?? "Unknown error."),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
        }
    }

    func keyboardType(from type: String?) -> UIKeyboardType {
        switch type {
        case "emailAddress": return .emailAddress
        case "phonePad": return .phonePad
        case "numberPad": return .numberPad
        case "decimalPad": return .decimalPad
        default: return .default
        }
    }
}
