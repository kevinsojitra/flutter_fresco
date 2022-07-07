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
  final _platformChannelPlugin = FrescoPlugin();
  @override
  void initState() {
    super.initState();

   initFresco();
  }

  // Platform messages are asynchronous, so we initialize in an async method.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin Fresco Example'),
          ),
          body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4,
              childAspectRatio: 0.7,
              mainAxisSpacing: 4,
            ),
            itemBuilder: (context, index) {
              return const MyImageView.fromUrl(
                url:
                    "https://wallpaper.thebharatapps.com/img/images/00807a37-08fa-4a71-b1ea-9214d52c925c.jpg",
                fit: BoxFit.fitWidth,
                backgroundColor: Colors.red,
              );
            },
            itemCount: 100,
          )),
    );
  }

  void initFresco() {
    FrescoPlugin.getFile("https://wallpaper.thebharatapps.com/img/images/00807a37-08fa-4a71-b1ea-9214d52c925c.jpg").then((path){
      print(path);
    });
    if (!mounted) return;
  }
}
