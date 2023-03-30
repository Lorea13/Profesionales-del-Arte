import 'dart:convert';
import 'package:frontend/helpers/urls.dart';
import 'package:frontend/models/personType.dart';
import 'package:frontend/models/person.dart';
import 'package:frontend/models/casting.dart';
import 'package:frontend/models/client.dart';
import 'package:frontend/models/activityType.dart';
import 'package:frontend/models/activity.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

/// Obtiene todos los castings de la base de datos
///
/// Hace una llamada al endpoint gracias a la URI de helpers/urls allCastings, que nos devuelve una Future List de los castings. Es una Future List debido a que, al ser una llamada a la API, la data no se obtiene de manera inmediata. Por cada elemento de la respuesta, creamos un casting y lo añadimos a [castings], que es lo que retornamos.
Future<List<Casting>> getCastings(
  List<Person> peopleList) async {
  Client client = http.Client();

  List<Casting> castings = [];

  List response = json.decode((await client.get(allCastings())).body);

  for (var casting in response) {
    int id = int.parse(casting['id']);
    Date date = Date.parse(casting['date']);
    String name = casting['name'];
    //Los id empiezan desde 1, pero las posiciones de una lista desde 0. Por eso, para asignar un director de casting se resta 1 al id, para obtener su posición en la lista
    Person castingDirector = peopleList[casting['castingDirector'] - 1];
    Person director = peopleList[casting['director'] - 1];
    bool inPerson = casting['inPerson'];
    bool inProcess = casting['inProcess'];
    String notes = casting['notes'];

    castings.add(Casting(
      id,
      date,
      name,
      castingDirector,
      director,
      inPerson
      inProcess,
      notes,
    ));
  }
  return castings;
}


/// Crea un casting
///
/// Se nos pasa como parametro el casting a crear [casting]. Sus campos se crean en un body json. Después llamamos al endpoint gracias a la URI createCastingUri de helpers/urls. Retorna el ID del casting creado si la acción se completa correctamente (status code == 200), y 0 en caso contrario (ya que los ids empiezan en 1, no existe el ID 0. Si se retorna este valor, sabremos que se ha producido un error y no realizaremos la acción).
Future<int> createCasting(Casting casting) async {
  Client client = http.Client();
  var bodyEncoded = jsonEncode({
    "date": casting.date
    "name": casting.name,
    "castingDirector": casting.castingDirector.id.toString(),
    "director": casting.director.id.toString(),
    "inPerson": casting.inPerson,
    "inProcess": casting.inProcess,
    "notes": casting.notes,
  });

  var response = await client.post(createCastingUri(),
      headers: {"Content-Type": "application/json"}, body: bodyEncoded);

  if (response.statusCode == 200) {
    int id = int.parse(json.decode((response).body)['id']);
    return id;
  }
  return 0;
}

///Modifica un casting
///
///Se pasa como parametro el casting modificado [casting]. Sus campos se crean en un body json. Después llamamos al endpoint gracias a la URI updateCastingUri de helpers/urls, al que le pasamos el id del casting a modificar. Retorna true si la operación se completa exitosamente (codigo de respuesta == 200) y false en caso contrario.
Future<bool> updateCasting(Casting casting) async {
  Client client = http.Client();
  var bodyEncoded = jsonEncode({
    "date": casting.date
    "name": casting.name,
    "castingDirector": casting.castingDirector.id.toString(),
    "director": casting.director.id.toString(),
    "inPerson": casting.inPerson,
    "inProcess": casting.inProcess,
    "notes": casting.notes,
  });

  var response = await client.put(updateCastingUri(casting.id.toString()),
      headers: {"Content-Type": "application/json"}, body: bodyEncoded);

  if (response.statusCode == 200) {
    return true;
  }
  return false;
}

///Elimina un casting
///
///Se pasa como parametro el id del casting a eliminar [id]. Llamamos al endpoint gracias a la URI deleteCastingUri de helpers/urls, al que le pasamos el id del casting a eliminar. Retorna true si la operación se completa exitosamente (codigo de respuesta == 200) y false en caso contrario.
Future<bool> deleteCasting(int id) async {
  Client client = http.Client();

  var response = await client.get(deleteCastingUri(id.toString()),
      headers: {"Content-Type": "application/json"});

  if (response.statusCode == 200) {
    return true;
  }
  return false;
}
