import Flutter
import UIKit
import SwiftUI
import miniSDKFramework

public class FlutterMiniSdkPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(
            name: "flutter_mini_sdk",
            binaryMessenger: registrar.messenger()
        )
        let instance = FlutterMiniSdkPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)

        let factory = MiniSDKViewFactory(messenger: registrar.messenger())
        registrar.register(factory, withId: "mini_sdk_view")
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "initialize":
            if let args = call.arguments as? [String: Any],
               let endpoint = args["apiEndpoint"] as? String {
                MiniSDK.shared.initialize(apiEndpoint: endpoint)
                result("Initialized: \(endpoint)")
            } else {
                result(FlutterError(code: "BAD_ARGS", message: "No endpoint", details: nil))
            }
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}

// A factory that creates the native view
public class MiniSDKViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }

    public func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return MiniSDKView(frame: frame, viewId: viewId, args: args)
    }
}

// The actual native view that wraps your SwiftUI form
public class MiniSDKView: NSObject, FlutterPlatformView {
    private let _view: UIView

    init(frame: CGRect, viewId: Int64, args: Any?) {
        var endpoint = "https://default.example.com"
        if let dict = args as? [String: Any],
           let givenEndpoint = dict["apiEndpoint"] as? String {
            endpoint = givenEndpoint
        }

        MiniSDK.shared.initialize(apiEndpoint: endpoint)
        let swiftUIView = MiniSDK.shared.getFormView()
        let hostingController = UIHostingController(rootView: swiftUIView)
        hostingController.view.frame = frame
        _view = hostingController.view

        super.init()
    }

    public func view() -> UIView {
        return _view
    }
}
