package com.view.fresco;

import android.content.Context;

import androidx.annotation.NonNull;

import com.facebook.drawee.backends.pipeline.Fresco;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** FrescoPlugin */
public class FrescoPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private Context context;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "fresco");
    channel.setMethodCallHandler(this);
    context = flutterPluginBinding.getApplicationContext();
    flutterPluginBinding.getPlatformViewRegistry()
            .registerViewFactory("fresco/my_image_view", new MyImageViewFactory());
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("getFile")) {
      String url = (String) call.arguments;
      DownloaderHelper.start(context, url, new OnDownloadListener() {
        @Override
        public void onDownloadComplete(String path) {
          result.success(path);
        }
      });

    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }


}
