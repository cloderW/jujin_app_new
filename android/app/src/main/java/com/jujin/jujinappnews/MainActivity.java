package com.jujin.jujinappnews;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public class MainActivity extends FlutterActivity {

  private static final String CHANNEL = "com.jujin.news/article";


  @Override
  protected void onCreate(final Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
              new MethodCallHandler() {
                  @Override
                  public void onMethodCall(MethodCall call, Result result) {


                      if("articleDetail".equals(call.method)) {
                          Intent intent = new Intent(MainActivity.this, WebViewActivity.class);
                          intent.putExtra("content",call.argument("content").toString());
                          intent.putExtra("title",call.argument("title").toString());
                          intent.putExtra("theme",call.argument("theme").toString());
                          startActivity(intent);
                      }

                  }
              });
  }
}
