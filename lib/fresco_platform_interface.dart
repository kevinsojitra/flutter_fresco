import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'fresco_method_channel.dart';

abstract class FrescoPlatform extends PlatformInterface {
  /// Constructs a FrescoPlatform.
  FrescoPlatform() : super(token: _token);

  static final Object _token = Object();

  static FrescoPlatform _instance = MethodChannelFresco();

  /// The default instance of [FrescoPlatform] to use.
  ///
  /// Defaults to [MethodChannelFresco].
  static FrescoPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FrescoPlatform] when
  /// they register themselves.
  static set instance(FrescoPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getFile(String url) {
    throw UnimplementedError('getFile() has not been implemented.');
  }
}
