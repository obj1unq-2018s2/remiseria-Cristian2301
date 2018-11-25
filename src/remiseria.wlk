
class Remiseria {
	const flotaDeVehiculos = {} 
	const viajesHechos = #{}
	
	method agregarAFlota(vehiculo){
		flotaDeVehiculos.add(vehiculo)
	}
	
	method quitarDeFlota(vehiculo){
		flotaDeVehiculos.remove(vehiculo)
	}
	
	method pesoTotalFlota(){
		return flotaDeVehiculos.sum {vehiculo => vehiculo.peso()}
	}
	
	method esRecomendable(){
		return self.tieneTresOMasVehiculos() and self.todosLosVehiculosPuedenIrACienOMas()
	}
	
	method tieneTresOMasVehiculos(){
		return flotaDeVehiculos.size() >= 3
	}
	
	method todosLosVehiculosPuedenIrACienOMas(){
		return flotaDeVehiculos.all {vehiculo => vehiculo.velocidadMaxima() >= 100}
	}
	
	method capacidadTotalYendoA(velocidad){
		return self.vehiculosConVelocidadMaximaMayorOIgualA(velocidad).sum {vehiculo => vehiculo.capacidad()}
	}
	
	method vehiculosConVelocidadMaximaMayorOIgualA(velocidad){
		return flotaDeVehiculos.filter {vehiculo => vehiculo.velocidadMaxima() >= velocidad}
	}
	
	method colorDelAutoMasRapido(){
		return flotaDeVehiculos.max {vehiculo => vehiculo.velocidadMaxima()}.color()
	}
	
	method coloresDeVehiculos(){
		return flotaDeVehiculos.map {vehiculo => vehiculo.color()}.asSet()
	}
	
	method cantidadVehiculosDe(color){
		return flotaDeVehiculos.count {vehiculo => vehiculo.color() == color}
	}
	
	method autosQuePuedenHacer(viaje){
		return flotaDeVehiculos.filter {vehiculo => viaje.puedeHacerViaje(vehiculo)}
	}
	
	method registrarViaje(viaje, vehiculo){
		viajesHechos.add(viaje)
		viaje.vehiculo(vehiculo)
	}
	
	method cantViajesHizo(auto){
		return viajesHechos.count {viaje => viaje.vehiculo() == auto}
	}
	
	method cantViajesDeMasDe(km){
		return viajesHechos.count {viaje => viaje.km() > km}
	}
	
	method lugareslibresTotalesEnViajes(){
		return viajesHechos.sum {viaje => viaje.vehiculo().capacidad() - viaje.cantPasajeros()}
	}
	
	method cantPagoA(auto){
		return self.viajesQueHizo(auto).sum {viaje => viaje.costo()}
	}
	
	method viajesQueHizo(auto){
		return viajesHechos.filter {viaje => viaje.vehiculo() == auto}
	}
}


class ChevroletCorsa  {
	const property capacidad = 4
	const velocidadMaxima = 150
	const property peso = 1300
	var property color
	
	method velocidadMaxima(){
		return velocidadMaxima
	} 

}



class AutoStandardAGas {
	const tieneTanqueAd = false
	const color = "gris"
	
	method capacidad(){
		return if(tieneTanqueAd) 3 else 4
	}
	
	method velocidadMaxima(){
		return if(tieneTanqueAd) 120 else 110
	}
	
	method peso(){
		return if(not tieneTanqueAd) 1200 else 1200 + 150
	}
	
}


class Trafic {
	var interior
	var motor
	const color = "blanco"
	
	method capacidad(){
		return interior.capacidad()
	}
	
	method velocidadMaxima(){
		return motor.velocidadMaxima()
	}
	
	method peso(){
		return 4000 + interior.peso() + motor.peso()
	}
}

object interiorComodo {
	const property capacidad = 5
	const property peso = 700
}

object interiorPopular {
	const property capacidad = 12
	const property peso = 1000
}

object motorPulenta {
	const property velocidadMaxima = 130
	const property peso = 800
}

object motorBataton {
	const property velocidadMaxima = 80
	const property peso = 500
}



class AutoDistinto {
	const property capacidad = 0
	const property velocidadMaxima = 0
	const property peso = 0
	var property color
}


class Viaje{
	const property km = 0
	const tiempoMaximo = 0
	const cantPasajeros = 0
	const coloresIncompatibles = #{}
	var property vehiculo
	const valorPorKm = 0
	const precioMinimo = 0
	
	method velocidadPromedio(){
		return km / tiempoMaximo
	}
	method puedeHacerViaje(auto){
		return self.velocidadMaximaDiezKmMayorALaPromedio(auto) and self.entranLosPasajerosEn(auto) and not self.esIncompatible(auto)
	}
	
	method velocidadMaximaDiezKmMayorALaPromedio(auto){
		return auto.velocidadMaxima() - self.velocidadPromedio() >= 10
	}
	
	method entranLosPasajerosEn(auto){
		return auto.capacidad() >= cantPasajeros
	}
	
	method esIncompatible(auto){
		return coloresIncompatibles.contains(auto.color())
	}
	
	method costo(){
		return if(valorPorKm * km < precioMinimo) precioMinimo else valorPorKm * km
	}
	
}






