package com.example.carryvent;

import java.util.List;

import android.os.Bundle;
import android.app.ActionBar.LayoutParams;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.util.Log;
import android.view.Gravity;
import android.view.Menu;
import android.view.View;
import android.widget.RadioButton;
import android.widget.TableLayout;
import android.widget.TableRow;
import android.widget.TextView;
import android.widget.Toast;

public class ListaPasajeros extends Activity {
	
	DataBasePasajes databasePasajes = new DataBasePasajes(this);
	TableLayout tablaPasajes;
	List<String[]> listaPasajeros;
	RadioButton ida, regreso;	

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.lista_pasajeros);
		tablaPasajes = (TableLayout)findViewById(R.id.tablaPasajes);
		ida = (RadioButton)findViewById(R.id.ida);
		regreso = (RadioButton)findViewById(R.id.regreso);
		listaPasajeros = databasePasajes.seleccionarTodo();
		if (ida.isChecked()){
			llenarTabla(1);
		}
		else{
			llenarTabla(2);
		}
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.carryvent, menu);
		return true;
	}
	
	public void idaORegreso(View view) {
	    boolean checked = ((RadioButton) view).isChecked();
	    
	    switch(view.getId()) {
	        case R.id.ida:
	            if (checked)
	            	llenarTabla(1);
	            break;
	        case R.id.regreso:
	            if (checked)
	            	llenarTabla(2);
	            break;
	    }
	}
	
	public void llenarTabla(int idaORegreso){
		tablaPasajes.removeAllViews();
		TableRow cabecera = new TableRow(this);
		TextView cabeceraNombre, cabeceraNumAsiento, cabeceraEstadoPasaje;
		cabecera.setLayoutParams(new LayoutParams(LayoutParams.WRAP_CONTENT,LayoutParams.WRAP_CONTENT));
		cabeceraNombre = new TextView(this);
		cabeceraNombre.setGravity(Gravity.CENTER_HORIZONTAL);
		cabeceraNombre.setText("Nombre Usuario");
		cabeceraNumAsiento = new TextView(this);
		cabeceraNumAsiento.setGravity(Gravity.CENTER_HORIZONTAL);
		cabeceraNumAsiento.setText("Nï¿½ Asiento");
		cabeceraEstadoPasaje = new TextView(this);
		cabeceraEstadoPasaje.setGravity(Gravity.CENTER_HORIZONTAL);
		cabeceraEstadoPasaje.setText("Estado");
		cabecera.addView(cabeceraNombre);
		cabecera.addView(cabeceraNumAsiento);
		cabecera.addView(cabeceraEstadoPasaje);
		tablaPasajes.addView(cabecera);
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
			if(idaORegreso == 1){
				if(listaPasajeros.get(i)[3].compareTo("0") == 0){
					estadoPasaje.setText("No Ingresado");
				}
				else{
					estadoPasaje.setText("Ingresado");
				}
			}
			else{
				if(listaPasajeros.get(i)[3].compareTo("0") == 0 || listaPasajeros.get(i)[3].compareTo("1") == 0){
					estadoPasaje.setText("No Ingresado");
				}
				else{
					estadoPasaje.setText("Ingresado");
				}
			}
			fila.addView(nombre);
			fila.addView(numAsiento);
			fila.addView(estadoPasaje);
			tablaPasajes.addView(fila);
		}
	}
	
	// Funciones para leer el cï¿½digo QR
	public void leerCodigo(View v){
		Intent intent = new Intent("com.google.zxing.client.android.SCAN");
        intent.putExtra("SCAN_MODE", "QR_CODE_MODE,PRODUCT_MODE");
        startActivityForResult(intent, 0);
	}
	
	public void onActivityResult(int requestCode, int resultCode, Intent intent) {
		String[] resultado;
		Context context = getApplicationContext();
        if (requestCode == 0) {
           if (resultCode == RESULT_OK) {
               
              String contents = intent.getStringExtra("SCAN_RESULT");
              
              resultado = databasePasajes.buscarPasaje(contents);
              if (resultado[0].compareTo("_Error1_") == 0){
            	  Toast.makeText(context, "Código no encontrado", Toast.LENGTH_SHORT).show();
              }
              else if (resultado[0].compareTo("_Error2_") == 0){
            	  Toast.makeText(context, "No se ha ingresado un código", Toast.LENGTH_SHORT).show();
              }
              else{
            	  if (ida.isChecked()){
            		  if (resultado[2].compareTo("1") == 0 || resultado[2].compareTo("2") == 0){
                		  Toast.makeText(context, "Código ya ingresado", Toast.LENGTH_SHORT).show();
                	  }
                	  else{
                		  Toast.makeText(context, "Usuario: "+ resultado[0] + "\nAsiento: " + resultado[1], Toast.LENGTH_LONG).show();
                		  databasePasajes.checkPasaje(contents,"1");
                		  for(int i = 0; i < listaPasajeros.size(); i++){
                			  if (listaPasajeros.get(i)[2].compareTo(resultado[1]) == 0){
                				  String[] confirmar = new String[4];
                				  confirmar[0] = listaPasajeros.get(i)[0];
                				  confirmar[1] = listaPasajeros.get(i)[1];
                				  confirmar[2] = listaPasajeros.get(i)[2];
                				  confirmar[3] = "1";
                				  listaPasajeros.set(i,confirmar);
                			  }
                		  }
                		  llenarTabla(1);
                	  }
            	  }
            	  else{
            		  if (resultado[2].compareTo("2") == 0){
                		  Toast.makeText(context, "Código ya ingresado", Toast.LENGTH_SHORT).show();
                	  }
            		  else if (resultado[2].compareTo("0") == 0){
            			  Toast.makeText(context, "El código leido no tiene registro de Ida", Toast.LENGTH_SHORT).show();
            		  }
                	  else{
                		  Toast.makeText(context, "Usuario: "+ resultado[0] + "\nAsiento: " + resultado[1], Toast.LENGTH_LONG).show();
                		  databasePasajes.checkPasaje(contents,"2");
                		  for(int i = 0; i < listaPasajeros.size(); i++){
                			  if (listaPasajeros.get(i)[2].compareTo(resultado[1]) == 0){
                				  String[] confirmar = new String[4];
                				  confirmar[0] = listaPasajeros.get(i)[0];
                				  confirmar[1] = listaPasajeros.get(i)[1];
                				  confirmar[2] = listaPasajeros.get(i)[2];
                				  confirmar[3] = "2";
                				  listaPasajeros.set(i,confirmar);
                			  }
                		  }
                		  llenarTabla(2);
                	  }
            	  }
              }
           	} else if (resultCode == RESULT_CANCELED) {
              // Handle cancel
              Log.i("App","Scan unsuccessful");
           	}
        }
	}

}
