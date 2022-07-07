import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'fresco_platform_interface.dart';

/// An implementation of [FrescoPlatform] that uses method channels.
class MethodChannelFresco extends FrescoPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('fresco');

  @override
  Future<String?> getFile(String url) async {
    final file = await methodChannel.invokeMethod<String>('getFile',url);
    return file;
  }
}
