package com.example.carryvent;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.JSONException;
import org.json.JSONObject;

import android.util.Log;

public class ConectarJson {
	static InputStream is = null;
	static JSONObject jObj = null;
	static String json = "";
	
	// constructor
	public ConectarJson() {
	}
	
	public JSONObject getJSON(String url) {
		// Making HTTP request
		try {
			URL link = new URL(url);
			HttpURLConnection conn = (HttpURLConnection) link.openConnection();
			conn.setReadTimeout(10000);
			conn.setConnectTimeout(15000);
			conn.setRequestMethod("GET");
			conn.setDoInput(true);
			conn.connect();
			is = conn.getInputStream();
			BufferedReader reader = new BufferedReader(new InputStreamReader(is, "UTF-8") );
			String data = null;
			String webPage = "";
			while ((data = reader.readLine()) != null){
				webPage += data + "\n";
			}
			reader.close();
			is.close();
			conn.disconnect();
			json = webPage;
		} catch (Exception e) {
			Log.e("Buffer Error", "Error converting result " + e.toString());
		}
		// try parse the string to a JSON object
		try {
			jObj = new JSONObject(json);
		} catch (JSONException e) {
			Log.e("JSON Parser", "Error parsing data " + e.toString());
		}
		// return JSON String
		return jObj;
	}
}