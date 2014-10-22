package com.example.carryvent;

import java.util.List;

import android.os.Bundle;
import android.app.ActionBar.LayoutParams;
import android.app.Activity;
import android.view.Gravity;
import android.view.Menu;
import android.widget.TableLayout;
import android.widget.TableRow;
import android.widget.TextView;

public class ListaPasajeros extends Activity {
	
	DataBase database = new DataBase(this);
	TableLayout tablaPasajes;
	List<String[]> listaPasajeros; 

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.lista_pasajeros);
		tablaPasajes = (TableLayout)findViewById(R.id.tablaPasajes);
		listaPasajeros = database.seleccionarTodo();
		llenarTabla();
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.carryvent, menu);
		return true;
	}
	
	public void llenarTabla(){
		for(int i = 0; i < listaPasajeros.size(); i++){
			TableRow fila = new TableRow(this);
			TextView nombre, numAsiento, estadoPasaje;
			fila.setLayoutParams(new LayoutParams(LayoutParams.WRAP_CONTENT,LayoutParams.WRAP_CONTENT));
			nombre = new TextView(this);
			nombre.setGravity(Gravity.CENTER_HORIZONTAL);
			nombre.setText(listaPasajeros.get(i)[1]);
			numAsiento = new TextView(this);
			numAsiento.setGravity(Gravity.CENTER_HORIZONTAL);
			numAsiento.setText(listaPasajeros.get(i)[2]);
			estadoPasaje = new TextView(this);
			estadoPasaje.setGravity(Gravity.CENTER_HORIZONTAL);
			if(listaPasajeros.get(i)[3].equals("0")){
				estadoPasaje.setText("No Ingresado");
			}
			else{
				estadoPasaje.setText("Ingresado");
			}
			fila.addView(nombre);
			fila.addView(numAsiento);
			fila.addView(estadoPasaje);
			tablaPasajes.addView(fila);
		}
	}

}
