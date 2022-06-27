import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fresco/fresco.dart';
import 'package:fresco/my_image_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _frescoPlugin = Fresco();

  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text ('Plugin examplconst e app'),
        ),
        body: Container(


          child:  MyImageView.fromUrl(
            url:
                "https://wallpaper.thebharatapps.com/img/images/00807a37-08fa-4a71-b1ea-9214d52c925c.jpg",
            options: ImageOptions(backgroundColor: Colors.black,scaleType: ScaleType.fitCenter,progressImage: 'images/progress.png'),

          ),
        ),
      ),
    );
  }
  Future<Uint8List> getProgressImage(String name) async {
    ByteData imageBytes = await rootBundle.load(name);
    return imageBytes.buffer.asUint8List();
  }

}
