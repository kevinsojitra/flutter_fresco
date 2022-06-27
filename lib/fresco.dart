
import 'fresco_platform_interface.dart';

class Fresco {
  Future<String?> getPlatformVersion() {
    return FrescoPlatform.instance.getPlatformVersion();
  }
}
