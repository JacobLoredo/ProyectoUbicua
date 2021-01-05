class CategoriP {
  final int id;
  
  final String nombre;

  CategoriP({this.nombre,this.id});

  factory CategoriP.fromJson(Map<String, dynamic> json) {
    return CategoriP(
        id: json['id'],
        nombre: json['Nombre']);
  }
  }