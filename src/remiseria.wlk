
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
		return 
	}
}


class ChevroletCorsa  {
	const property capacidad = 4
	const property velocidadMaxima = 150
	const property peso = 1300
	const property color 

}

class Classic inherits ChevroletCorsa {
	
	override method velocidadMaxima(){
		return 200
	}
	
}


class Viaje{
	const property km = 0
	const tiempoMaximo = 0
	const cantPasajeros = 0
	const coloresIncompatibles = #{}
	const property vehiculo
	
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
		return 
	}
	
}






