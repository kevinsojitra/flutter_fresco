package com.view.fresco_example;

import android.os.Bundle;

import androidx.annotation.NonNull;

import com.view.fresco.MyImageViewFactory;

import java.util.Objects;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        flutterEngine
                .getPlatformViewsController()
                .getRegistry()
                .registerViewFactory("fresco/my_image_view", new MyImageViewFactory());
    }
}
