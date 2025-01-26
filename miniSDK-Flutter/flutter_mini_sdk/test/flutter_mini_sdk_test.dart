import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_mini_sdk/flutter_mini_sdk.dart';
import 'package:flutter_mini_sdk/flutter_mini_sdk_platform_interface.dart';
import 'package:flutter_mini_sdk/flutter_mini_sdk_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterMiniSdkPlatform
    with MockPlatformInterfaceMixin
    implements FlutterMiniSdkPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterMiniSdkPlatform initialPlatform = FlutterMiniSdkPlatform.instance;

  test('$MethodChannelFlutterMiniSdk is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterMiniSdk>());
  });

  test('getPlatformVersion', () async {
    FlutterMiniSdk flutterMiniSdkPlugin = FlutterMiniSdk();
    MockFlutterMiniSdkPlatform fakePlatform = MockFlutterMiniSdkPlatform();
    FlutterMiniSdkPlatform.instance = fakePlatform;

    expect(await flutterMiniSdkPlugin.getPlatformVersion(), '42');
  });
}
