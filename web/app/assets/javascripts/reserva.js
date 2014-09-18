$(document).ready(function() {
	var seleccionados = $("#seleccionados");
	seleccionados.val(0);
});

function seleccionar(id){
	var asiento = $("#"+id);
	var seleccionados = $("#seleccionados");
	var numSelec = parseInt(seleccionados.val());
	var tag = $("#"+(id+"tag"));
	if(numSelec < 5){
		if(asiento.val() == false){
			asiento.val(true);
			tag.attr("name", "reserva[asientos][]");
			asiento.find("img").attr("src","/assets/asientoSeleccionado.png");
			seleccionados.val(numSelec + 1);
			return false;
		}
		if(asiento.val() == true){
			asiento.val(false);
			tag.removeAttr("name");
			asiento.find("img").attr("src","/assets/asientoSinSeleccionar.png");
			seleccionados.val(numSelec - 1);
			return false;
		}
	}
	else if(numSelec == 5 && asiento.val() == true){
		asiento.val(false);
		tag.removeAttr("name");

		asiento.find("img").attr("src","/assets/asientoSinSeleccionar.png");
		seleccionados.val(numSelec - 1);
		return false;
	}
	else{
		alert("No puedes reservar más asientos");
	}
}