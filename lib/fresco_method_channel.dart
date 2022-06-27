import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'fresco_platform_interface.dart';

/// An implementation of [FrescoPlatform] that uses method channels.
class MethodChannelFresco extends FrescoPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('fresco');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
