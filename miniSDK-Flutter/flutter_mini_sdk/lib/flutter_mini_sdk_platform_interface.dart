import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_mini_sdk_method_channel.dart';

abstract class FlutterMiniSdkPlatform extends PlatformInterface {
  /// Constructs a FlutterMiniSdkPlatform.
  FlutterMiniSdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterMiniSdkPlatform _instance = MethodChannelFlutterMiniSdk();

  /// The default instance of [FlutterMiniSdkPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterMiniSdk].
  static FlutterMiniSdkPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterMiniSdkPlatform] when
  /// they register themselves.
  static set instance(FlutterMiniSdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
