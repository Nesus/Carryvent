package com.example.carryvent;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.os.AsyncTask;
import android.os.Bundle;
import android.app.Activity;
import android.content.Context;
import android.graphics.Bitmap;
import android.view.Menu;
import android.view.View;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemSelectedListener;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

public class ListaEventos extends Activity {
	
	Spinner listaEventos;
	TextView nombre, lugar, fecha, hora;
	ImageView imagen;
	Button obtenerLista, obtenerRuta;
	Map<String, String[]> informacionEventos = new HashMap<String, String[]>();
	List<String> nombreEventos = new ArrayList<String>();
	DataBasePasajes databasePasajes = new DataBasePasajes(this);
	DataBaseRuta databaseRuta = new DataBaseRuta(this);
	LinearLayout informacion;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.lista_eventos);
		
		listaEventos = (Spinner)findViewById(R.id.listaEventos);
		nombre = (TextView)findViewById(R.id.nombreEvento);
		lugar = (TextView)findViewById(R.id.lugarEvento);
		fecha = (TextView)findViewById(R.id.fechaEvento);
		hora = (TextView)findViewById(R.id.horaEvento);
		imagen = (ImageView)findViewById(R.id.imagenEvento);
		obtenerLista = (Button)findViewById(R.id.obtenerLista);
		obtenerRuta = (Button)findViewById(R.id.obtenerRuta);
		informacion = (LinearLayout)findViewById(R.id.informacion);
		
		nombreEventos.add("- Lista de Eventos -");
		new JSONParseEventos().execute("http://192.168.0.2:3000/operario/list_eventos");
		ArrayAdapter<String> adapter = new ArrayAdapter<String>(this,
			android.R.layout.simple_spinner_item, nombreEventos);
		adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
		listaEventos.setAdapter(adapter);
		listaEventos.setOnItemSelectedListener(new CustomOnItemSelectedListener());
		informacion.setVisibility(View.INVISIBLE);
		obtenerLista.setVisibility(View.INVISIBLE);
		obtenerRuta.setVisibility(View.INVISIBLE);
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.carryvent, menu);
		return true;
	}
	
	public void obtenerListaPasajeros(View v){
		/*Primero se deben subir a la página la informacion sobre los asistentes
		  a eventos anteriores que estén almacenados en la base de datos, luego
		  se eliminan estos elementos de la base de datos y se cargan los nuevo.
		  Finalmente se muestra un mensaje avisando que todo se a cargado.*/
		Context context = getApplicationContext();
		databasePasajes.dropPasajes();
		new JSONParsePasajes().execute("http://192.168.0.2:3000/operario/list_pasajes/"+informacionEventos.get(listaEventos.getSelectedItem().toString())[0]);
		Toast.makeText(context, "Datos cargados", Toast.LENGTH_SHORT).show();
	}
	
	public void obtenerRuta(View v){
		Context context = getApplicationContext();
		databaseRuta.dropRuta();
		new JSONParseRuta().execute("http://192.168.0.2:3000/operario/ruta_evento/"+informacionEventos.get(listaEventos.getSelectedItem().toString())[0]);
		Toast.makeText(context, "Ruta cargada", Toast.LENGTH_SHORT).show();
	}
	
	// Clase para realizar la conexi�n y obtener el Json de eventos
	public class JSONParseEventos extends AsyncTask<String, String, JSONObject> {
		
		protected void onPreExecute() {
			super.onPreExecute();
		}
		
		@Override
		protected JSONObject doInBackground(String... arg0) {
			String url = (String)arg0[0];
			ConectarJson jParser = new ConectarJson();
			JSONObject json = jParser.getJSON(url);
			return json;
		}
		
		@Override
		protected void onPostExecute(JSONObject json) {
			try {
				JSONArray eventos = null;
				eventos = json.getJSONArray("eventos");
				for (int i=0; i<eventos.length(); i++){
					JSONObject c = eventos.getJSONObject(i);
					String[] informacion = {c.getString("id"),c.getString("name"),c.getString("address"),c.getString("date"),c.getString("time"),c.getString("image")};
					informacionEventos.put(c.getString("name"), informacion);
					nombreEventos.add(c.getString("name"));			
				}
			} catch (JSONException e) {
				Context context = getApplicationContext();
				Toast.makeText(context, "No se ha podido cargar la lista de Eventos", Toast.LENGTH_SHORT).show();
			} catch (NullPointerException e){
				Context context = getApplicationContext();
				Toast.makeText(context, "No se ha podido cargar la lista de Eventos", Toast.LENGTH_SHORT).show();
			}
		}
	}
	
	// Clase para realizar la conexi�n y obtener el Json de pasajes
	public class JSONParsePasajes extends AsyncTask<String, String, JSONObject> {
		
		protected void onPreExecute() {
			super.onPreExecute();
		}
		
		@Override
		protected JSONObject doInBackground(String... arg0) {
			String url = (String)arg0[0];
			ConectarJson jParser = new ConectarJson();
			JSONObject json = jParser.getJSON(url);
			return json;
		}
		
		@Override
		protected void onPostExecute(JSONObject json) {
			try {
				JSONArray pasajes = null;
				pasajes = json.getJSONArray("pasajes");
				for (int i=0; i<pasajes.length(); i++){
					JSONObject c = pasajes.getJSONObject(i);
					String code = c.getString("code");
					String name = c.getString("name");
					String asiento = c.getString("asiento");
					databasePasajes.agregarPasaje(code, name, asiento);		
				}
			} catch (JSONException e) {
				e.printStackTrace();
			}
		}
	}
	
	// Clase para realizar la conexión y obtener el Json de la Ruta
	public class JSONParseRuta extends AsyncTask<String, String, JSONObject> {
		
		protected void onPreExecute() {
			super.onPreExecute();
		}
		
		@Override
		protected JSONObject doInBackground(String... arg0) {
			String url = (String)arg0[0];
			ConectarJson jParser = new ConectarJson();
			JSONObject json = jParser.getJSON(url);
			return json;
		}
		
		@Override
		protected void onPostExecute(JSONObject json) {
			try {
				JSONArray ruta = json.getJSONArray("ruta");
				JSONArray waypoints;				
				JSONObject c = ruta.getJSONObject(0);
				waypoints = c.getJSONArray("waypoints");
				databaseRuta.agregarPunto(1, c.getJSONArray("inicio").getDouble(0), c.getJSONArray("inicio").getDouble(1));
				databaseRuta.agregarPunto(2, c.getJSONArray("fin").getDouble(0), c.getJSONArray("fin").getDouble(1));
				for (int i = 0; i < waypoints.length(); i++){
					databaseRuta.agregarPunto(i+3, waypoints.getJSONArray(i).getDouble(0), waypoints.getJSONArray(i).getDouble(1));
				}
			} catch (JSONException e) {
				e.printStackTrace();
			}
		}
	}
	
	// Clase para modificar la información del evento seleccionado
	public class CustomOnItemSelectedListener implements OnItemSelectedListener {
		 
		public void onItemSelected(AdapterView<?> parent, View view, int pos,long id) {
			if (parent.getItemAtPosition(pos).toString().compareTo("- Lista de Eventos -") == 0){
				nombre.setText("");
				lugar.setText("");
				fecha.setText("");
				hora.setText("");
				imagen.setImageBitmap(null);
				informacion.setVisibility(View.INVISIBLE);
				obtenerLista.setVisibility(View.INVISIBLE);
				obtenerRuta.setVisibility(View.INVISIBLE);
			}
			else{
				nombre.setText("Nombre del Evento: " + informacionEventos.get(parent.getItemAtPosition(pos).toString())[1]);
				lugar.setText("Lugar: " + informacionEventos.get(parent.getItemAtPosition(pos).toString())[2]);
				fecha.setText("Fecha: " + informacionEventos.get(parent.getItemAtPosition(pos).toString())[3]);
				hora.setText("Hora: " + informacionEventos.get(parent.getItemAtPosition(pos).toString())[4]);
				new ImageGet().execute("http://192.168.0.2:3000" + informacionEventos.get(parent.getItemAtPosition(pos).toString())[5]);
				informacion.setVisibility(View.VISIBLE);
				obtenerLista.setVisibility(View.VISIBLE);
				obtenerRuta.setVisibility(View.VISIBLE);
			}
		}
 
		@Override
		public void onNothingSelected(AdapterView<?> arg0) {
			// TODO Auto-generated method stub
		}
	}
	
	// Clase para realizar la conexión y obtener la imagen del eventos
		public class ImageGet extends AsyncTask<String, String, Bitmap> {
			
			protected void onPreExecute() {
				super.onPreExecute();
			}
			
			@Override
			protected Bitmap doInBackground(String... arg0) {
				String url = (String)arg0[0];
				ConectarImagen imageGet = new ConectarImagen();
				Bitmap image = imageGet.getImagen(url);
				return image;
			}
			
			@Override
			protected void onPostExecute(Bitmap image) {
				imagen.setImageBitmap(image);
			}
		}

}
