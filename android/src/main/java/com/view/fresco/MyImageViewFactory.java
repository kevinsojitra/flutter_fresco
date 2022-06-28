package com.view.fresco;

import android.content.Context;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class MyImageViewFactory extends PlatformViewFactory {

    public MyImageViewFactory() {
        super(StandardMessageCodec.INSTANCE);
    }

    @NonNull
    @Override
    public PlatformView create( Context context, int id, Object args) {
        final Map<String, Object> creationParams = (Map<String, Object>) args;
        return new FlutterMyImageView(context, id, creationParams);
    }
}