package com.example.carryvent;

import java.util.ArrayList;
import java.util.List;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

//Clase encargada de la base de datos de Ruta
public class DataBaseRuta extends SQLiteOpenHelper{
    private static final String NOMBRE_BASEDATOS_RUTA = "ruta.db";
    
    private static final String TABLA_RUTA = "CREATE TABLE ruta" +  
            "(_id INTEGER PRIMARY KEY, latitud REAL, longitud REAL)";
	
    public DataBaseRuta(Context context) {
    	super(context, NOMBRE_BASEDATOS_RUTA, null, 1);
    }
 
    @Override
    public void onCreate(SQLiteDatabase db) {
    	db.execSQL(TABLA_RUTA);
    }
 
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
    	db.execSQL("DROP TABLE IF EXISTS " + TABLA_RUTA);
    	onCreate(db);
    }
 
    public void agregarPunto(int id, double latitud, double longitud) {
    	SQLiteDatabase db = getWritableDatabase();
    	if (db != null){
    		 ContentValues valores = new ContentValues();
    		 valores.put("_id",id);
    		 valores.put("latitud", latitud);
    		 valores.put("longitud", longitud);
    		 db.insert("ruta", null, valores);
    		 db.close();
    	}
    }
    
    public List<double[]> seleccionarTodo() {
    	SQLiteDatabase db = getReadableDatabase();
        String[] campos = {"latitud", "longitud"};
        double[] datos = new double[2];
        List<double[]> resultado = new ArrayList<double[]>();
    	Cursor c = db.query("ruta", campos, null, 
    			null, null, null, null, null);
    	if(c.moveToFirst()) {
    		do{
    			datos[0] = c.getDouble(0);
    			datos[1] = c.getDouble(1);
    			resultado.add(datos);
    			datos = new double[2];
    		}while(c.moveToNext());
        }
    	c.close();
        db.close();
        return resultado;
    }
    
    public void dropRuta(){
    	SQLiteDatabase db = getWritableDatabase();
    	db.execSQL("DELETE FROM ruta");
    	db.close();
    }
}
