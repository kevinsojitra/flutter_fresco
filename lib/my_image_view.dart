import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

@immutable
class MyImageView extends StatelessWidget {
  final ImageOptions? options;
  final String url;

  const MyImageView.fromUrl({super.key, required this.url, this.options});

  @override
  Widget build(BuildContext context) {
    const String viewType = 'fresco/my_image_view';
    // Pass parameters to the platform side.
   /* Map<String, dynamic> creationParams = {"url": url};
    if (options!=null) {
      creationParams.addAll(options!.toMap());
    }*/
    return FutureBuilder<Map<String, dynamic>>(builder: (context, snapshot) {
      return snapshot.hasData?AndroidView(
        viewType: viewType,
        creationParams: setParam(snapshot),
        creationParamsCodec: const StandardMessageCodec(),
      ):const SizedBox();
    },future: getParam(),);
  }

  setParam(AsyncSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic> creationParams = {"url": url};
    if (snapshot.hasData) {
      creationParams.addAll(snapshot.data!);
    }
    return creationParams;
  }

  Future<Map<String, dynamic>> getParam() {
    return options!=null?options!.toMap(): Future.value(null);
  }
}

class ImageOptions {
  double? ratio;
  bool isCircle;
  Color backgroundColor;
  RoundOption? roundOption;
  ScaleType scaleType;
  String? progressImage;

  ImageOptions({this.ratio,
    this.isCircle = false,
    this.roundOption,
    this.progressImage,
    this.scaleType = ScaleType.center,
    this.backgroundColor = Colors.transparent});

  Future<Map<String, dynamic>> toMap() async {
    Map<String, dynamic> temp = {
      "isCircle": isCircle,
      "bgColor": backgroundColor.toHex(leadingHashSign: true),
      "scaleType": scaleType.value
    };
    if (roundOption != null) {
      temp.putIfAbsent("round", () => roundOption!.toMap());
    }
    if (ratio != null) {
      temp.putIfAbsent("ratio", () => ratio);
    }
    if (progressImage != null) {
      var bytes = await getProgressImage(progressImage!);
      temp.putIfAbsent(
          "progressImage", ()  {
        return bytes;
      });
    }
    print(temp);
    return temp;
  }
}

Future<Uint8List> getProgressImage(String name) async {
  ByteData imageBytes = await rootBundle.load(name);
  return imageBytes.buffer.asUint8List();
}

class RoundOption {
  double topLeft, topRight, bottomRight, bottomLeft;

  RoundOption({this.topLeft = 0.0,
    this.topRight = 0.0,
    this.bottomRight = 0.0,
    this.bottomLeft = 0.0});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> temp = {
      "topLeft": topLeft,
      "topRight": topRight,
      "bottomRight": bottomRight,
      "bottomLeft": bottomLeft,
    };

    return temp;
  }
}

extension HexColor on Color {
  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

enum ScaleType {
  fitXY(1),
  fitX(2),
  fitY(3),
  fitStart(4),
  fitCenter(5),
  fitEnd(6),
  center(7),
  centerInside(8),
  centerCrop(9),
  focuseCrop(10),
  fitBottomStart(11);

  const ScaleType(this.value);

  final num value;
}
