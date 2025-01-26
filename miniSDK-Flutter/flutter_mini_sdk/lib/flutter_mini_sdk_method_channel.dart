import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_mini_sdk_platform_interface.dart';

/// An implementation of [FlutterMiniSdkPlatform] that uses method channels.
class MethodChannelFlutterMiniSdk extends FlutterMiniSdkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_mini_sdk');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
