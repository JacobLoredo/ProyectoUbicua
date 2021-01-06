//**Clase para poder almacenar la informacion que viene de la API correspondiente a la Categoria */
//**id ->identificador de la categoria */
//**nombre->Nombre de la categoria */
class CategoriP {
  final int id;
  final String nombre;
  CategoriP({this.nombre,this.id});
//**Metodo para convertir un JSON en una categoria */
  factory CategoriP.fromJson(Map<String, dynamic> json) {
    return CategoriP(
        id: json['id'],
        nombre: json['Nombre']);
  }
  }