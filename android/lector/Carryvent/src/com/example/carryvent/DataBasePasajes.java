package com.example.carryvent;

import java.util.ArrayList;
import java.util.List;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

//Clase encargada de la base de datos de Pasajes
public class DataBasePasajes extends SQLiteOpenHelper{
    private static final String NOMBRE_BASEDATOS_PASAJES = "pasajes.db";
    
    private static final String TABLA_PASAJES = "CREATE TABLE pasajes" +  
            "(_codigo TEXT PRIMARY KEY, nombre TEXT, asiento TEXT, ingresado TEXT, subido TEXT)";
	
    public DataBasePasajes(Context context) {
    	super(context, NOMBRE_BASEDATOS_PASAJES, null, 1);
    }
 
    @Override
    public void onCreate(SQLiteDatabase db) {
    	db.execSQL(TABLA_PASAJES);
    	
    }
 
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
    	db.execSQL("DROP TABLE IF EXISTS " + TABLA_PASAJES);
    	onCreate(db);
    }
 
    public void agregarPasaje(String codigo, String nombre, String asiento) {
    	SQLiteDatabase db = getWritableDatabase();
    	if (db != null){
    		 ContentValues valores = new ContentValues();
    		 valores.put("_codigo",codigo);
    		 valores.put("nombre", nombre);
    		 valores.put("asiento", asiento);
    		 valores.put("ingresado", "0");
    		 valores.put("subido", "0");
    		 db.insert("pasajes", null, valores);
    		 db.close();
    	}
    }

    public String[] buscarPasaje(String codigo) {
    	SQLiteDatabase db = getReadableDatabase();
        String[] campos = {"nombre", "asiento", "ingresado"};
        String[] resultado = new String[3];
        if(codigo.compareTo("")!=0){
        	Cursor c = db.query("pasajes", campos, "_codigo='" + codigo + "'", 
        			null, null, null, null, null);
        	if(c.moveToFirst()) {
	            resultado[0] = c.getString(0);
	            resultado[1] = c.getString(1);
	            resultado[2] = c.getString(2);
	        }
        	else{
        		resultado[0] = "_Error1_"; //Código no encontrado
        	}
        	c.close();
        }
        else{
        	resultado[0] = "_Error2_"; //No se ha ingresado código
        }
        db.close();
        return resultado;
    }
    
    public void checkPasaje(String codigo, String estado){
        SQLiteDatabase db = getWritableDatabase();
        ContentValues valores = new ContentValues();
        valores.put("ingresado", estado);
	 	db.update("pasajes", valores, "_codigo= '" + codigo +"'", null);
	 	db.close();   
    }
    
    public List<String[]> seleccionarTodo() {
    	SQLiteDatabase db = getReadableDatabase();
        String[] campos = {"_codigo", "nombre", "asiento", "ingresado"};
        String[] datos = new String[4];
        List<String[]> resultado = new ArrayList<String[]>();
    	Cursor c = db.query("pasajes", campos, null, 
    			null, null, null, null, null);
    	if(c.moveToFirst()) {
    		do{
    			datos[0] = c.getString(0);
    			datos[1] = c.getString(1);
    			datos[2] = c.getString(2);
    			datos[3] = c.getString(3);
    			resultado.add(datos);
    			datos = new String[4];
    		}while(c.moveToNext());
        }
    	c.close();
        db.close();
        return resultado;
    }
    
    public void dropPasajes(){
    	SQLiteDatabase db = getWritableDatabase();
    	db.execSQL("DELETE FROM pasajes");
    	db.close();
    }
}
