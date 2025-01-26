import 'dart:async';
import 'package:flutter/services.dart';

class FlutterMiniSdk {
  static const MethodChannel _channel = MethodChannel('flutter_mini_sdk');

  /// Initialize the MiniSDK with an API endpoint
  static Future<void> initialize(String apiEndpoint) async {
    // Note: fix the spelling to 'initialize' to match your iOS side
    await _channel.invokeMethod('initialize', {
      "apiEndpoint": apiEndpoint,
    });
    // No return needed, so it returns null automatically for a `void` function
  }
}