package com.jujin.jujinappnews;


import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.net.Uri;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.view.MenuItem;
import android.view.Window;
import android.webkit.JsResult;
import android.webkit.ValueCallback;
import android.webkit.WebChromeClient;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;



import java.lang.ref.WeakReference;

public class WebViewActivity extends Activity {

    private final String TAG = "WebViewActivity ";
    private WebView webview;
    private String url;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        webview = new WebView(this);
        setContentView(webview);
        getActionBar().setDisplayHomeAsUpEnabled(true);
        getActionBar().setTitle(getIntent().getStringExtra("title"));
        if ("light".equals(getIntent().getStringExtra("theme"))){
            ColorDrawable drawable = new ColorDrawable(Color.parseColor("#ffff8600"));
            getActionBar().setBackgroundDrawable(drawable);
        }else{
            ColorDrawable drawable = new ColorDrawable(Color.parseColor("#ff000000"));
            getActionBar().setBackgroundDrawable(drawable);

        }

        //设置webview的settings和client

        webview.setWebViewClient(new WebViewClient() {
            public boolean shouldOverrideUrlLoading(WebView view, String url)
            { // 重写此方法表明点击网页里面的链接还是在当前的webview里跳转，不跳到浏览器那边
                view.loadUrl(url);
                return true;
            }
        });

        // 加载 页面
        webview.loadDataWithBaseURL("http://www.9dfx.com/", getIntent().getStringExtra("content"), "text/html", "utf-8", null);

        webview.getSettings().setJavaScriptEnabled(true);//启用js
        webview.getSettings().setBlockNetworkImage(false);//解决图片不显示


    }


    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case android.R.id.home:
                this.finish(); // back button
                return true;
        }
        return super.onOptionsItemSelected(item);
    }




}
