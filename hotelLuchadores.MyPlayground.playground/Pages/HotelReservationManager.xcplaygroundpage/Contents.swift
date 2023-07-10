import Foundation

struct Client {
    let nombre: String
    let edad: Int
    let altura: Double
}

struct Reservation {
    var id: Int
    let nombreHotel: String
    var listaDeReservas: [Client]
    var duracionEstancia: Int
    var precio: Double
    var desayuno: Bool
}

enum ReservationError: Error {
    case idDuplicada
    case reservaDuplicada
    case reservaNoEncontrada
}


var idCode = 1

class HotelReservationManager {
    
    //DECLARO listaDeReservas es de tipo Reservation
    var listaDeReservas: [Reservation] = []
    var idAlreadyExists = false

    // FUNCION COMPRUEBA SI EL ID ESTA DUPLICADO
    func isIdDuplicada() -> Bool {
        for id in listaDeReservas {
            if id.id == idCode {
                idAlreadyExists = true
                assert(false, "Número de Id ya utilizado")
                break
            }
        }
        if !idAlreadyExists {
            print("Número de Id correcto")
        }
        return idAlreadyExists
    }
    
    // FUNCION QUE COMPRUEBA SI LA RESERVA YA ESTA DUPLICADA
    func isReservaDuplicada() -> Bool {
        for reserva in listaDeReservas {
            if listaDeReservas.contains(where: { $0.id == reserva.id}) {
                assert(false, "Error: reserva ya en el sistema.!")
                return true
            }
        }
        return false
    }

    // FUNCION QUE AGREGA +1 AL ID SIGUIENTE
    func generarID() -> Int {
        idCode += 1
        return idCode
    }

    // FUNCION QUE AÑADE NUEVA RESERVA
    func addReserva(reserva: Reservation) {
        if !isIdDuplicada() {
            let nuevaID = generarID()/2
            var agregarReserva = reserva
            agregarReserva.id = nuevaID
            listaDeReservas.append(agregarReserva)
            print("Reserva agregada correctamente")
            generarID()
        }
    }
    
    //FUNCION QUE CALCULA EL PRECIO DE LA RESERVA
    func calcularPrecio(numeroDeClientes: Double, duracionEstancia: Double, desayuno: Bool) -> Double {
        let precioBase = 20.0
        let precioDesayuno = desayuno ? 1.25 : 1.0
        return numeroDeClientes * precioBase * duracionEstancia * precioDesayuno
    }
    
    // FUNCION PARA CANCELAR RESERVAS
    
    func cancelarReserva(id: Int) throws {
        guard let index = listaDeReservas.firstIndex(where: { $0.id == id }) else {
            throw ReservationError.reservaNoEncontrada
        }
        listaDeReservas.remove(at: index)
        print("Reserva con ID \(id) cancelada correctamente.")
    }
    
    // RESERVAS ACTUALES
    var reservasActuales: [Reservation] {
        return listaDeReservas
    }
}


//LISTADO DE LOS CLIENTES
var cliente1 = Client(nombre: "Goku", edad: 44, altura: 1.75)
var cliente2 = Client(nombre: "Vegeta", edad: 48, altura: 1.64)
var cliente3 = Client(nombre: "Krilin", edad: 44, altura: 1.53)
var cliente4 = Client(nombre: "Roshi", edad: 350, altura: 1.60)

//LISTADO DE RESERVAS
var reserva1 = Reservation(id: 0, nombreHotel: "Hotal Namek Resort", listaDeReservas: [cliente1], duracionEstancia: 8, precio: 0.0, desayuno: true)
var reserva2 = Reservation(id: 0, nombreHotel: "Hotal Namek Resort", listaDeReservas: [cliente2], duracionEstancia: 5, precio: 0.0, desayuno: false)
var reserva3 = Reservation(id: 0, nombreHotel: "Hotal Namek Resort", listaDeReservas: [cliente3], duracionEstancia: 14, precio: 0.0, desayuno: true)
var reserva4 = Reservation(id: 0, nombreHotel: "Hotal Namek Resort", listaDeReservas: [cliente4], duracionEstancia: 22, precio: 0.0, desayuno: false)



// INSTACION LA CLASE HOTEL
var open1 = HotelReservationManager()

// CALCULO EL PRECIO DE LA RESERVA
var precioReserva1 = open1.calcularPrecio(numeroDeClientes: Double(reserva1.listaDeReservas.count), duracionEstancia: Double(reserva1.duracionEstancia), desayuno: reserva1.desayuno)
var precioReserva2 = open1.calcularPrecio(numeroDeClientes: Double(reserva2.listaDeReservas.count), duracionEstancia: Double(reserva2.duracionEstancia), desayuno: reserva2.desayuno)
var precioReserva3 = open1.calcularPrecio(numeroDeClientes: Double(reserva3.listaDeReservas.count), duracionEstancia: Double(reserva3.duracionEstancia), desayuno: reserva3.desayuno)
var precioReserva4 = open1.calcularPrecio(numeroDeClientes: Double(reserva4.listaDeReservas.count), duracionEstancia: Double(reserva4.duracionEstancia), desayuno: reserva4.desayuno)


//GESTION UN BUCLE PARA IR AÑADIENDO RESERVAS
reserva1.precio = precioReserva1
reserva2.precio = precioReserva2
reserva3.precio = precioReserva3
reserva4.precio = precioReserva4

    
// SI NO ESTA DUPLICADO EL ID Y LA RESERVA EJECUTO EN AÑADIR
if !open1.isIdDuplicada() && !open1.isReservaDuplicada(){
        open1.addReserva(reserva: reserva1)
        open1.addReserva(reserva: reserva2)
        open1.addReserva(reserva: reserva3)
        open1.addReserva(reserva: reserva4)
        
    }

// IMPRIMO LAS RESERVAS
for reserva in open1.listaDeReservas {
    print(reserva)
}

// CANCELAR RESERVA
do {
    try open1.cancelarReserva(id: 2 ) // CANCELA LA RESERVA DEL NUMERO DE ID QUE INDIQUES
} catch {
    if let reservationError = error as? ReservationError {
        switch reservationError {
        case .reservaNoEncontrada:
            print("Error: la reserva no existe.")
        default:
            print("Error desconocido al cancelar la reserva.")
        }
    }
}

//IMPRIME DE NUEVO TODAS LAS RESERVAS

for reserva in open1.reservasActuales {
    print(reserva)
}



"""
TEST
"""

testAddReservation()
testCancelReservation()
testReservationPrice()


func testAddReservation() {
    var open1 = HotelReservationManager()

    var cliente1 = Client(nombre: "Goku", edad: 44, altura: 1.75)
    var cliente2 = Client(nombre: "Vegeta", edad: 48, altura: 1.64)
    var cliente3 = Client(nombre: "Krilin", edad: 44, altura: 1.53)
    var cliente4 = Client(nombre: "Roshi", edad: 350, altura: 1.60)

    var reserva1 = Reservation(id: 0, nombreHotel: "Hotal Namek Resort", listaDeReservas: [cliente1], duracionEstancia: 8, precio: 0.0, desayuno: true)
    var reserva2 = Reservation(id: 0, nombreHotel: "Hotal Namek Resort", listaDeReservas: [cliente2], duracionEstancia: 5, precio: 0.0, desayuno: false)
    var reserva3 = Reservation(id: 0, nombreHotel: "Hotal Namek Resort", listaDeReservas: [cliente3], duracionEstancia: 14, precio: 0.0, desayuno: true)
    var reserva4 = Reservation(id: 0, nombreHotel: "Hotal Namek Resort", listaDeReservas: [cliente4], duracionEstancia: 22, precio: 0.0, desayuno: false)

    // AGREGAR LA PRIMERA RESERVA CORRECTAMENTE
    open1.addReserva(reserva: reserva1)
    
    // INTENTAR AGREGAR UNA RESERVA DUPLICADA POR ID
    open1.addReserva(reserva: reserva1)
    // EL RESULTADO ESPERADO SERIA MOSTRA EL MENSAJE DE ERROR "Número de Id ya utilizado"
    
    // INTENTAR AGREGAR UNA RESERVA CON UN CLIENTE QUE YA ESTA EN OTRA RESERVA
    open1.addReserva(reserva: reserva2)
    // EL RESULTADO ESPERADO SERIA MOSTRAR EL MENSAJE DE ERROR "Error: reserva ya en el sistema."
    
    // AGREGAR UNA NUEVA RESERVA CORRECTAMENTE
    open1.addReserva(reserva: reserva3)
    
    // IMPRIMIR RESERVAS ACTUALES, EN ESTE CASO COMO SE HACE UNA NUEVA LLAMADA GENERA UNAS ID CORRELATIVAS)
    print("Reservas actuales:")
    for reserva in open1.reservasActuales {
        print(reserva)
    }
}




func testCancelReservation() {
    var open1 = HotelReservationManager()

    var cliente1 = Client(nombre: "Goku", edad: 44, altura: 1.75)
    var cliente2 = Client(nombre: "Vegeta", edad: 48, altura: 1.64)

    var reserva1 = Reservation(id: 1, nombreHotel: "Hotal Namek Resort", listaDeReservas: [cliente1], duracionEstancia: 8, precio: 0.0, desayuno: true)
    var reserva2 = Reservation(id: 2, nombreHotel: "Hotal Namek Resort", listaDeReservas: [cliente2], duracionEstancia: 5, precio: 0.0, desayuno: false)

    open1.addReserva(reserva: reserva1)
    open1.addReserva(reserva: reserva2)

    // Cancelar una reserva existente
    do {
        try open1.cancelarReserva(id: 1)
        // Se espera que la reserva con ID 1 se elimine del listado de reservas
        print("Reserva con ID 1 cancelada correctamente.")
    } catch {
        print("Error al cancelar la reserva: \(error)")
    }

    // Intentar cancelar una reserva inexistente
    do {
        try open1.cancelarReserva(id: 3)
        // No debería llegar a este punto, ya que la reserva con ID 3 no existe y debería lanzar un error
    } catch {
        if let reservationError = error as? ReservationError, reservationError == .reservaNoEncontrada {
            print("Error al cancelar la reserva: \(reservationError)")
        } else {
            print("Error desconocido al cancelar la reserva.")
        }
    }

    // Imprimir las reservas actuales para verificar que la reserva con ID 1 se haya eliminado
    print("Reservas actuales:")
    for reserva in open1.reservasActuales {
        print(reserva)
    }
}


func testReservationPrice() {
    var open1 = HotelReservationManager()

    var cliente1 = Client(nombre: "Goku", edad: 44, altura: 1.75)
    var cliente2 = Client(nombre: "Vegeta", edad: 48, altura: 1.64)

    var reserva1 = Reservation(id: 1, nombreHotel: "Hotal Namek Resort", listaDeReservas: [cliente1], duracionEstancia: 8, precio: 0.0, desayuno: true)
    var reserva2 = Reservation(id: 2, nombreHotel: "Hotal Namek Resort", listaDeReservas: [cliente2], duracionEstancia: 8, precio: 0.0, desayuno: true)

    open1.addReserva(reserva: reserva1)
    open1.addReserva(reserva: reserva2)

    let precioReserva1 = open1.calcularPrecio(numeroDeClientes: Double(reserva1.listaDeReservas.count), duracionEstancia: Double(reserva1.duracionEstancia), desayuno: reserva1.desayuno)
    let precioReserva2 = open1.calcularPrecio(numeroDeClientes: Double(reserva2.listaDeReservas.count), duracionEstancia: Double(reserva2.duracionEstancia), desayuno: reserva2.desayuno)

    print("Precio de reserva 1: \(precioReserva1)")
    print("Precio de reserva 2: \(precioReserva2)")

    if precioReserva1 == precioReserva2 {
        print("Los precios de las reservas son iguales.")
    } else {
        print("Los precios de las reservas son diferentes.")
    }
}
