import 'package:fresco/fresco_platform_interface.dart';

class FrescoPlugin{

  static Future<String?> getFile(String url) {
    return FrescoPlatform.instance.getFile(url);
  }
}