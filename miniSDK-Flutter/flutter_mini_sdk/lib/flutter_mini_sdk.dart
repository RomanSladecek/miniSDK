import 'dart:async';
import 'package:flutter/services.dart';

class FlutterMiniSdk {
  static const MethodChannel _channel = MethodChannel('flutter_mini_sdk');

  static Future<void> initialize(String apiEndpoint) async {
    await _channel.invokeMethod('initialize', {
      "apiEndpoint": apiEndpoint,
    });
    // No return needed, so it returns null automatically for a `void` function
  }
}