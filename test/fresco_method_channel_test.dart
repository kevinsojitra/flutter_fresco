import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fresco/fresco_method_channel.dart';

void main() {
  MethodChannelFresco platform = MethodChannelFresco();
  const MethodChannel channel = MethodChannel('fresco');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
