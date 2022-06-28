package com.view.fresco;

import android.content.Context;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.graphics.drawable.BitmapDrawable;
import android.view.View;

import androidx.annotation.NonNull;

import com.facebook.drawee.backends.pipeline.Fresco;
import com.facebook.drawee.drawable.AutoRotateDrawable;
import com.facebook.drawee.drawable.ScalingUtils;
import com.facebook.drawee.generic.GenericDraweeHierarchy;
import com.facebook.drawee.generic.GenericDraweeHierarchyBuilder;
import com.facebook.drawee.generic.RoundingParams;

import java.util.Map;
import java.util.Objects;

import io.flutter.plugin.platform.PlatformView;

public class FlutterMyImageView implements PlatformView {
    @NonNull
    private final DynamicHeightImageView imageView;

    FlutterMyImageView(@NonNull Context context, int id, @NonNull Map<String, Object> creationParams) {
        if (!Fresco.hasBeenInitialized()) {
            Fresco.initialize(context);
        }
        imageView = new DynamicHeightImageView(context);
        imageView.setId(id);
        byte[] b = (byte[]) creationParams.get("progressImage");
        GenericDraweeHierarchy hierarchy = new GenericDraweeHierarchyBuilder(context.getResources())
                .setActualImageScaleType(ScalingUtils.ScaleType.CENTER_INSIDE)
                .setFadeDuration(700)
                .build();
        if (b != null) {
            hierarchy.setProgressBarImage(new AutoRotateDrawable(new BitmapDrawable(context.getResources(), BitmapFactory.decodeByteArray(b, 0, b.length)), 1000), ScalingUtils.ScaleType.CENTER_INSIDE);
        }
        if (creationParams.containsKey("scaleType")) {
            hierarchy.setActualImageScaleType(getScaleType(Integer.parseInt(Objects.requireNonNull(creationParams.get("scaleType")).toString())));
        }
        if (creationParams.containsKey("bgColor")) {
            imageView.setBackgroundColor(Color.parseColor(Objects.requireNonNull(creationParams.get("bgColor")).toString()));
        }
        if (Boolean.parseBoolean(Objects.requireNonNull(creationParams.get("isCircle")).toString())) {
            hierarchy.setRoundingParams(RoundingParams.asCircle());
        } else if (creationParams.containsKey("round")) {
            Map<String, Object> roundParam = (Map<String, Object>) creationParams.get("round");
            if (roundParam != null) {
                hierarchy.setRoundingParams(RoundingParams.fromCornersRadii(Float.parseFloat(Objects.requireNonNull(roundParam.get("topLeft")).toString()), Float.parseFloat(Objects.requireNonNull(roundParam.get("topRight")).toString()), Float.parseFloat(Objects.requireNonNull(roundParam.get("bottomRight")).toString()), Float.parseFloat(Objects.requireNonNull(roundParam.get("bottomLeft")).toString())));
            }
        }
        imageView.setHierarchy(hierarchy);
        if (creationParams.containsKey("ratio")) {
            imageView.setRatio(Float.parseFloat(Objects.requireNonNull(creationParams.get("ratio")).toString()));
        }

        imageView.setImageURI(String.valueOf(creationParams.get("url")));
    }

    @Override
    public View getView() {
        return imageView;
    }

    @Override
    public void dispose() {
    }


    public ScalingUtils.ScaleType getScaleType(int type) {
        switch (type) {
            case 1:
                return ScalingUtils.ScaleType.FIT_XY;
            case 2:
                return ScalingUtils.ScaleType.FIT_X;
            case 3:
                return ScalingUtils.ScaleType.FIT_Y;
            case 4:
                return ScalingUtils.ScaleType.FIT_START;
            case 5:
                return ScalingUtils.ScaleType.FIT_CENTER;
            case 6:
                return ScalingUtils.ScaleType.FIT_END;
            case 8:
                return ScalingUtils.ScaleType.CENTER_INSIDE;
            case 9:
                return ScalingUtils.ScaleType.CENTER_CROP;
            case 10:
                return ScalingUtils.ScaleType.FOCUS_CROP;
            case 11:
                return ScalingUtils.ScaleType.FIT_BOTTOM_START;
            case 7:
                return ScalingUtils.ScaleType.CENTER;
            default:
                throw new IllegalStateException("Unexpected value: " + type);
        }
    }
}