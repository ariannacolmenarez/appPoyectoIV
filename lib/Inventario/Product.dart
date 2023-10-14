
class Productos {
  final int id;
  final String nombre;
  final String url_img;
  final String marca;
  final int precio_venta;
  final int cantidad;

  const Productos({
    required this.id,
    required this.nombre,
    required this.url_img,
    required this.marca,
    required this.precio_venta,
    required this.cantidad,
  });

  static Productos fromJson(json) => Productos(
    id: json['id'],
    nombre : json['nombre'],
    url_img :'https://joseviveresmarket.000webhostapp.com/'+json['url_img'],
    marca :json['marca'],
    precio_venta:json['precio_venta'],
    cantidad: json['cantidad'],
  );
}