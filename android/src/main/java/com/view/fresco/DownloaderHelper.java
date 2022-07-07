package com.view.fresco;

import android.content.Context;
import android.graphics.Bitmap;
import android.widget.Toast;

import com.facebook.common.executors.UiThreadImmediateExecutorService;
import com.facebook.common.references.CloseableReference;
import com.facebook.datasource.DataSource;
import com.facebook.drawee.backends.pipeline.Fresco;
import com.facebook.imagepipeline.core.ImagePipeline;
import com.facebook.imagepipeline.datasource.BaseBitmapDataSubscriber;
import com.facebook.imagepipeline.image.CloseableImage;
import com.facebook.imagepipeline.request.ImageRequest;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;

public class DownloaderHelper {


    public static void start(final Context context, final String image, final OnDownloadListener listener) {
        if (!Fresco.hasBeenInitialized()) {
            Fresco.initialize(context);
        }
        ImageRequest imageRequest = ImageRequest.fromUri(image);
        ImagePipeline imagePipeline = Fresco.getImagePipeline();
        DataSource<CloseableReference<CloseableImage>> dataSource = imagePipeline.fetchDecodedImage(imageRequest, context);
        dataSource.subscribe(
                new BaseBitmapDataSubscriber() {

                    @Override
                    protected void onNewResultImpl(Bitmap bitmap) {
                        OutputStream fOut = null;
                        String name = String.format("cache_image_fresco.%s", image.contains("png") ? "png" : "jpg");
//                       String name = new File(image).getName();
                        File file = new File(context.getCacheDir(), name);
                        try {
                            fOut = new FileOutputStream(file);
                            if (name.endsWith("png")) {
                                bitmap.compress(Bitmap.CompressFormat.PNG, 100, fOut);
                            } else {
                                bitmap.compress(Bitmap.CompressFormat.JPEG, 100, fOut);
                            }
                            fOut.flush(); // Not really required
                            fOut.close(); // do not forget to close the stream
                            listener.onDownloadComplete(file.getAbsolutePath());
                        } catch (FileNotFoundException e) {
                            e.printStackTrace();
                        } catch (IOException e) {
                            e.printStackTrace();
                        }


                    }


                    @Override
                    protected void onFailureImpl(DataSource<CloseableReference<CloseableImage>> dataSource) {
                        Toast.makeText(context, "Download Failed", Toast.LENGTH_SHORT).show();
                    }
                },
                UiThreadImmediateExecutorService.getInstance());

    }
}
