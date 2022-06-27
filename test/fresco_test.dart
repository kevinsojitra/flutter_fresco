import 'package:flutter_test/flutter_test.dart';
import 'package:fresco/fresco.dart';
import 'package:fresco/fresco_platform_interface.dart';
import 'package:fresco/fresco_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFrescoPlatform 
    with MockPlatformInterfaceMixin
    implements FrescoPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FrescoPlatform initialPlatform = FrescoPlatform.instance;

  test('$MethodChannelFresco is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFresco>());
  });

  test('getPlatformVersion', () async {
    Fresco frescoPlugin = Fresco();
    MockFrescoPlatform fakePlatform = MockFrescoPlatform();
    FrescoPlatform.instance = fakePlatform;
  
    expect(await frescoPlugin.getPlatformVersion(), '42');
  });
}
