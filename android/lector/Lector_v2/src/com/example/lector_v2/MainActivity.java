package com.example.lector_v2;

import java.util.ArrayList;
import java.util.List;

import android.os.Bundle;
import android.app.Activity;
import android.content.ContentValues;
import android.content.Context;
import android.content.Intent;
import android.content.res.Configuration;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;
import android.view.Menu;
import android.view.View;
import android.widget.TextView;

public class MainActivity extends Activity {

	TextView resultado, nombres, estados, codigo;
	List<String[]> listaPasajeros; 
	DataBase database = new DataBase(this);
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		resultado = (TextView)findViewById(R.id.resultado);
		nombres = (TextView)findViewById(R.id.valoresNombre);
		estados = (TextView)findViewById(R.id.valoresEstado);
		codigo = (TextView)findViewById(R.id.boxCodigo);
		listaPasajeros = database.selectAll();
		llenarTabla();
	}
	
	@Override
	public void onConfigurationChanged(Configuration newConfig) {
		super.onConfigurationChanged(newConfig);
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.main, menu);
		return true;
	}
	
	public void llenarTabla(){
		nombres.setText("");
		estados.setText("");
		for(int i = 0; i < listaPasajeros.size(); i++){
			nombres.setText(nombres.getText() + listaPasajeros.get(i)[0] + "\n");
			if(listaPasajeros.get(i)[1].compareTo("N")==0){
				estados.setText(estados.getText() + "No ingresado \n");
			}
			else{
				estados.setText(estados.getText() + "Ingresado \n");
			}
		}
	}
	
	public int buscarResultado(String contenido){
		for(int i = 0 ;i < listaPasajeros.size(); i++){
			if(listaPasajeros.get(i)[2].compareTo(contenido) == 0)
				return i;
		}
		return -1;
	}
	
	public void ingresar(View v){
		int indice = buscarResultado(codigo.getText().toString());
		if(indice != -1){
      	  resultado.setText("Resultado: " + listaPasajeros.get(indice)[0]);
      	  listaPasajeros.get(indice)[1] = "Ingresado";
      	  database.update(codigo.getText().toString());
      	  llenarTabla();
        }
        else{
      	  resultado.setText("Resultado: Código no encontrado");
        }
		codigo.setText("");
	}
	
	public void escanear(View v){
		Intent intent = new Intent("com.google.zxing.client.android.SCAN");
        intent.putExtra("SCAN_MODE", "QR_CODE_MODE,PRODUCT_MODE");
        startActivityForResult(intent, 0);
	}
	
	public void onActivityResult(int requestCode, int resultCode, Intent intent) {
		int indice;
        if (requestCode == 0) {
           if (resultCode == RESULT_OK) {
               
              String contents = intent.getStringExtra("SCAN_RESULT");
              
              indice = buscarResultado(contents);
              if(indice != -1){
            	  resultado.setText("Resultado: " + listaPasajeros.get(indice)[0]);
            	  listaPasajeros.get(indice)[1] = "Ingresado";
            	  database.update(contents);
            	  llenarTabla();
              }
              else{
            	  resultado.setText("Resultado: Código no encontrado");
              }
              
                                        
           	} else if (resultCode == RESULT_CANCELED) {
              // Handle cancel
              Log.i("App","Scan unsuccessful");
           	}
        }
	}
	
	public class DataBase extends SQLiteOpenHelper{
	    private static final String NOMBRE_BASEDATOS = "pasajeros.db";
	    
	    private static final String TABLA_PRODUCTOS = "CREATE TABLE pasajeros" +  
	            "(_id INT PRIMARY KEY, nombre TEXT, estado TEXT, codigo TEXT)";
		
	    public DataBase(Context context) {
	    	super(context, NOMBRE_BASEDATOS, null, 1);
	    }

	    public void onCreate(SQLiteDatabase db) {
	    	db.execSQL(TABLA_PRODUCTOS);
	    	ContentValues valores = new ContentValues();
	    	valores.put("_id","00001");
	    	valores.put("nombre", "Cristopher Barraza");
	    	valores.put("estado", "N");
	    	valores.put("codigo", "00001CB000101");
	    	db.insert("pasajeros", null, valores);
	    	valores.clear();
	    	valores.put("_id","00002");
	    	valores.put("nombre", "German Ortiz");
	    	valores.put("estado", "N");
	    	valores.put("codigo", "00002GO000102");
	    	db.insert("pasajeros", null, valores);
	    	
	    }
	 
	    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
	    	db.execSQL("DROP TABLE IF EXISTS " + TABLA_PRODUCTOS);
	    	onCreate(db);
	    }
	    
	    public List<String[]> selectAll() {
	    	SQLiteDatabase db = getReadableDatabase();
	        String[] campos = {"nombre", "estado", "codigo"};
	        String[] datos = new String[3];
	        List<String[]> resultado = new ArrayList<String[]>();
        	Cursor c = db.query("pasajeros", campos, null, 
        			null, null, null, null, null);
        	if(c.moveToFirst()) {
        		do{
        			datos[0] = c.getString(0);
        			datos[1] = c.getString(1);
        			datos[2] = c.getString(2);
        			resultado.add(datos);
        			datos = new String[3];
        		}while(c.moveToNext());
	        }
        	c.close();
	        db.close();
	        return resultado;
	    }
	    
	    public void update(String codigo){
	        SQLiteDatabase db = getWritableDatabase();
	        ContentValues valores = new ContentValues();
   		 	valores.put("estado", "I");
   		 	db.update("pasajeros", valores, "codigo = '" + codigo + "'", null);
   		 	db.close();   
	    }

	}
}
