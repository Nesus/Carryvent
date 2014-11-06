package com.example.carryvent;

import java.net.HttpURLConnection;
import java.net.URL;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.util.Log;

public class ConectarImagen {
	static Bitmap bm = null;
	
	// constructor
	public ConectarImagen() {
	}
	
	public Bitmap getImagen(String url) {
		// Making HTTP request
		try {
			URL link = new URL(url);
			HttpURLConnection conn = (HttpURLConnection) link.openConnection();
			conn.setReadTimeout(10000);
			conn.setConnectTimeout(15000);
			conn.setRequestMethod("GET");
			conn.setDoInput(true);
			conn.connect();
			bm = BitmapFactory.decodeStream(conn.getInputStream());
			conn.disconnect();
		} catch (Exception e) {
			Log.e("Buffer Error", "Error converting result " + e.toString());
		}
		return bm;
	}
}