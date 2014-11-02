package com.example.carryvent;


import android.os.Bundle;
import android.app.Activity;
import android.content.Intent;
import android.view.Menu;
import android.view.View;

public class Carryvent extends Activity {

	DataBasePasajes databasePasajes = new DataBasePasajes(this);
	DataBaseRuta databaseRuta = new DataBaseRuta(this);
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_carryvent);
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.carryvent, menu);
		return true;
	}
	
	public void listaEventos(View v){
		Intent intent = new Intent(this, ListaEventos.class);
		startActivity(intent);
	}	
	
	public void listaPasajeros(View v){
		Intent intent = new Intent(this, ListaPasajeros.class);
		startActivity(intent);
	}
	
	public void mostrarRuta(View v){
		Intent intent = new Intent(this, Ruta.class);
		startActivity(intent);
	}

}
