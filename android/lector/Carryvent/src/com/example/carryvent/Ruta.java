package com.example.carryvent;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
 
import org.json.JSONObject;
 
import android.content.Context;
import android.graphics.Color;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v4.app.FragmentActivity;
import android.util.Log;
import android.view.Menu;
import android.widget.Toast;
 
import com.google.android.gms.maps.CameraUpdate;
import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.MapFragment;
import com.google.android.gms.maps.model.BitmapDescriptorFactory;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.MarkerOptions;
import com.google.android.gms.maps.model.PolylineOptions;
public class Ruta extends FragmentActivity {
 
    GoogleMap map;
    DataBaseRuta databaseRuta = new DataBaseRuta(this);
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.ruta);
        
        ConnectivityManager administradorConexion = (ConnectivityManager) getSystemService(Context.CONNECTIVITY_SERVICE);
        NetworkInfo informacionConexion = administradorConexion.getActiveNetworkInfo();
        if (informacionConexion != null){
        	map = ((MapFragment) getFragmentManager().findFragmentById(R.id.map)).getMap();
            if(map!=null){
            	// Initializing
                final List<double[]> puntos = databaseRuta.seleccionarTodo();
                if(puntos.size()>1){
                	final LatLng inicio;
            		final LatLng fin;
                    inicio = new LatLng(puntos.get(0)[0],puntos.get(0)[1]);
                    fin = new LatLng(puntos.get(1)[0],puntos.get(1)[1]);
                    
                	CameraUpdate centrar = CameraUpdateFactory.newLatLng(new LatLng(puntos.get(0)[0],puntos.get(0)[1]));
                	CameraUpdate zoom =CameraUpdateFactory.zoomTo(15);
                	map.moveCamera(centrar);
                    map.animateCamera(zoom);
                    map.setMyLocationEnabled(true);
                    MarkerOptions marcaInicio = new MarkerOptions();
                    marcaInicio.position(inicio);
                    marcaInicio.icon(BitmapDescriptorFactory.defaultMarker(BitmapDescriptorFactory.HUE_GREEN));
                    map.addMarker(marcaInicio);
                    MarkerOptions marcaFin = new MarkerOptions();
                    marcaFin.position(fin);
                    marcaFin.icon(BitmapDescriptorFactory.defaultMarker(BitmapDescriptorFactory.HUE_RED));
                    map.addMarker(marcaFin);

                    String url = getDirectionsUrl(puntos);

                    DownloadTask downloadTask = new DownloadTask();

                    // Start downloading json data from Google Directions API
                    downloadTask.execute(url);
                }
            }
        }
        else{
        	Context context = getApplicationContext();
			Toast.makeText(context, "No hay conexión a Internet para generar la ruta", Toast.LENGTH_SHORT).show();
        }
    }
 
    private String getDirectionsUrl(List<double[]> puntos){
 
        // Origin of route
        String str_origin = "origin="+puntos.get(0)[0]+","+puntos.get(0)[1];
 
        // Destination of route
        String str_dest = "destination="+puntos.get(1)[0]+","+puntos.get(1)[1];
        
        // Waypoints
        String str_waypoints = "";
        if (puntos.size()>2){
        	str_waypoints = "waypoints="+puntos.get(2)[0]+","+puntos.get(2)[1];
        	MarkerOptions marcaIntermedia = new MarkerOptions();
        	LatLng posicion = new LatLng(puntos.get(2)[0],puntos.get(2)[1]);
            marcaIntermedia.position(posicion);
            marcaIntermedia.icon(BitmapDescriptorFactory.defaultMarker(BitmapDescriptorFactory.HUE_YELLOW));
            map.addMarker(marcaIntermedia);
        	for (int i=3; i<puntos.size();i++){
            	str_waypoints += "|"+puntos.get(i)[0]+","+puntos.get(i)[1];
            	marcaIntermedia = new MarkerOptions();
            	posicion = new LatLng(puntos.get(i)[0],puntos.get(i)[1]);
                marcaIntermedia.position(posicion);
                marcaIntermedia.icon(BitmapDescriptorFactory.defaultMarker(BitmapDescriptorFactory.HUE_YELLOW));
                map.addMarker(marcaIntermedia);
            }
        }
 
        // Sensor enabled
        String sensor = "sensor=false";
 
        // Building the parameters to the web service
        String parameters = str_origin+"&"+str_dest+"&"+str_waypoints+"&"+sensor;
 
        // Output format
        String output = "json";
 
        // Building the url to the web service
        String url = "https://maps.googleapis.com/maps/api/directions/"+output+"?"+parameters;
 
        return url;
    }
    /** A method to download json data from url */
    private String downloadUrl(String strUrl) throws IOException{
    	String sb = "";
        InputStream iStream = null;
        HttpURLConnection urlConnection = null;
        try{
            URL url = new URL(strUrl);
 
            // Creating an http connection to communicate with url
            urlConnection = (HttpURLConnection) url.openConnection();
 
            // Connecting to url
            urlConnection.connect();
 
            // Reading data from url
            iStream = urlConnection.getInputStream();
 
            BufferedReader br = new BufferedReader(new InputStreamReader(iStream, "UTF-8"));
 
            String line = null;
            
            while( ( line = br.readLine()) != null){
                sb += line + "\n";
            }
 
            br.close();
 
        }catch(Exception e){
            Log.d("Exception while downloading url", e.toString());
        }finally{
            iStream.close();
            urlConnection.disconnect();
        }
        return sb;
    }
 
    // Fetches data from url passed
    private class DownloadTask extends AsyncTask<String, Void, String>{
 
        // Downloading data in non-ui thread
        @Override
        protected String doInBackground(String... url) {
 
            // For storing data from web service
            String data = "";
 
            try{
                // Fetching the data from web service
                data = downloadUrl(url[0]);
            }catch(Exception e){
                Log.d("Background Task",e.toString());
            }
            return data;
        }
 
        // Executes in UI thread, after the execution of
        // doInBackground()
        @Override
        protected void onPostExecute(String result) {
            super.onPostExecute(result);
 
            ParserTask parserTask = new ParserTask();
 
            // Invokes the thread for parsing the JSON data
            parserTask.execute(result);
        }
    }
 
    /** A class to parse the Google Places in JSON format */
    private class ParserTask extends AsyncTask<String, Integer, List<List<HashMap<String,String>>> >{
 
        // Parsing the data in non-ui thread
        @Override
        protected List<List<HashMap<String, String>>> doInBackground(String... jsonData) {
 
            JSONObject jObject;
            List<List<HashMap<String, String>>> routes = null;
 
            try{
                jObject = new JSONObject(jsonData[0]);
                DirectionsJSONParser parser = new DirectionsJSONParser();
 
                // Starts parsing data
                routes = parser.parse(jObject);
            }catch(Exception e){
                e.printStackTrace();
            }
            return routes;
        }
 
        // Executes in UI thread, after the parsing process
        @Override
        protected void onPostExecute(List<List<HashMap<String, String>>> result) {
            ArrayList<LatLng> points = null;
            PolylineOptions lineOptions = null;
 
            // Traversing through all the routes
            for(int i=0;i<result.size();i++){
                points = new ArrayList<LatLng>();
                lineOptions = new PolylineOptions();
 
                // Fetching i-th route
                List<HashMap<String, String>> path = result.get(i);
 
                // Fetching all the points in i-th route
                for(int j=0;j<path.size();j++){
                    HashMap<String,String> point = path.get(j);
 
                    double lat = Double.parseDouble(point.get("lat"));
                    double lng = Double.parseDouble(point.get("lng"));
                    LatLng position = new LatLng(lat, lng);
 
                    points.add(position);
                }
 
                // Adding all the points in the route to LineOptions
                lineOptions.addAll(points);
                lineOptions.width(3);
                lineOptions.color(Color.BLUE);
            }
 
            // Drawing polyline in the Google Map for the i-th route
            map.addPolyline(lineOptions);
        }
    }
 
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.carryvent, menu);
        return true;
    }
}