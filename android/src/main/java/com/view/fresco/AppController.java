package com.view.fresco;

import android.app.Application;

import com.facebook.drawee.backends.pipeline.Fresco;

public class AppController extends Application {
    @Override
    public void onCreate() {
        super.onCreate();
        Fresco.initialize(this);
    }
}
