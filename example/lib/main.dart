import 'dart:typed_data';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  var progressImage;

  @override
  void initState() {
    super.initState();
    setDAT();
  }

  // Platform messages are asynchronous, so we initialize in an async method.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin examplconst e app'),
          ),
          body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4,
              childAspectRatio: 0.7,
              mainAxisSpacing: 4,),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  print("DHDHDH");
                },
                child: MyImageView.fromUrl(
                  url:
                  "https://wallpaper.thebharatapps.com/img/images/00807a37-08fa-4a71-b1ea-9214d52c925c.jpg",
                  fit: BoxFit.fitWidth,
                  backgroundColor: Colors.red,
                  progressImage: progressImage,
                  tapGestureRecognizer: TapGestureRecognizer()
                    ..onTapDown = (details) {
                      print("TAPAPAPA");
                    },

                ),
              );
            },
            itemCount: 100,
          )),
    );
  }

  Future<Uint8List> getProgressImage(String name) async {
    ByteData imageBytes = await rootBundle.load(name);
    return imageBytes.buffer.asUint8List();
  }

  void setDAT() async {
    progressImage = await getProgressImage("images/progress.png");
    setState(() {

    });
  }
}
