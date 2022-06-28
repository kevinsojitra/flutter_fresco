import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fresco/scale_type.dart';

@immutable
class MyImageView extends StatelessWidget {
  final String url;
  final double? height, width;
  final double ratio;
  final bool isCircle;
  final Color backgroundColor;
  final BoxFit fit;
  final Uint8List? progressImage;
  final TapGestureRecognizer tapGestureRecognizer;

  const MyImageView.fromUrl(
      {super.key,
      required this.url,
      this.height,
      this.width,
      this.ratio = 0,
      this.isCircle = false,
      this.fit = BoxFit.none,
      this.backgroundColor = Colors.transparent,
      this.progressImage,
      required this.tapGestureRecognizer});

  @override
  Widget build(BuildContext context) {
    const String viewType = 'fresco/my_image_view';
    return SizedBox(
      width: width,
      height: height,
      child: PlatformViewLink(
        viewType: viewType,
        surfaceFactory: (context, controller) {
          return AndroidViewSurface(
            controller: controller as AndroidViewController,
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{}
              ..add(TapGestureRecognizer),
            hitTestBehavior: PlatformViewHitTestBehavior.opaque,
          );
        },
        onCreatePlatformView: (params) {
          return PlatformViewsService.initSurfaceAndroidView(
            id: params.id,
            viewType: viewType,
            layoutDirection: TextDirection.ltr,
            creationParams: setParam(),
            creationParamsCodec: const StandardMessageCodec(),
            onFocus: () {
              params.onFocusChanged(true);
            },
          )
            ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
            ..create();
        },
      ),
    );
  }

  setParam() {
    Map<String, dynamic> creationParams = {
      "url": url,
      "ratio": ratio,
      "isCircle": isCircle,
      "bgColor": backgroundColor.toHex(leadingHashSign: true),
      "scaleType": getScaleType(fit),
      "progressImage": progressImage,
    };

    return creationParams;
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
