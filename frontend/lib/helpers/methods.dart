import 'dart:convert';
import 'package:frontend/helpers/urls.dart';
import 'package:frontend/models/personType.dart';
import 'package:frontend/models/person.dart';
import 'package:frontend/models/casting.dart';
import 'package:frontend/models/company.dart';
import 'package:frontend/models/activityType.dart';
import 'package:frontend/models/activity.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


/// Obtiene todos los tipos personas de la base de datos
///
/// Hace una llamada al endpoint gracias a la URI de helpers/urls allPeople, que nos devuelve una Future List de las personas. Es una Future List debido a que, al ser una llamada a la API, la data no se obtiene de manera inmediata. Por cada elemento de la respuesta, creamos una persona y lo añadimos a [people], que es lo que retornamos.
Future<List<PersonType>> getPersonTypes() async {
  Client client = http.Client();

  List<PersonType> personTypes = [];

  List response = json.decode((await client.get(allPersonTypes())).body);

  for (var personType in response) {
    int id = int.parse(personType['id']);
    String name = personType['name'];

    personTypes.add(PersonType(
      id,
      name,
    ));
  }
  return personTypes;
}

/// Obtiene todos las personas de la base de datos
///
/// Hace una llamada al endpoint gracias a la URI de helpers/urls allPeople, que nos devuelve una Future List de las personas. Es una Future List debido a que, al ser una llamada a la API, la data no se obtiene de manera inmediata. Por cada elemento de la respuesta, creamos una persona y lo añadimos a [people], que es lo que retornamos.
Future<List<Person>> getPeople(
  List<PersonType> personTypesList) async {
  Client client = http.Client();

  List<Person> people = [];

  List response = json.decode((await client.get(allPeople())).body);

  for (var person in response) {
    int id = int.parse(person['id']);
    //Los id empiezan desde 1, pero las posiciones de una lista desde 0. Por eso, para asignar una persona se resta 1 al id, para obtener su posición en la lista
    PersonType type = personTypesList[person['type'] - 1];
    String name = person['name'];
    DateTime contactDate = DateTime.parse(person['contactDate']);
    String contactDescription = person['contactDescription'];
    String projects = person['projects'];
    String webPage = person['webPage'];
    String email = person['email'];
    String phone = person['phone'];
    String notes = person['notes'];

    people.add(Person(
      id,
      type,
      name,
      contactDate,
      contactDescription,
      projects,
      webPage,
      email,
      phone,
      notes,
    ));
  }
  return people;
}

/// Crea una persona
///
/// Se nos pasa como parametro el person a crear [person]. Sus campos se crean en un body json. Después llamamos al endpoint gracias a la URI createPersonUri de helpers/urls. Retorna el ID del person creado si la acción se completa correctamente (status code == 200), y 0 en caso contrario (ya que los ids empiezan en 1, no existe el ID 0. Si se retorna este valor, sabremos que se ha producido un error y no realizaremos la acción).
Future<int> createPerson(Person person) async {
  Client client = http.Client();
  var bodyEncoded = jsonEncode({
    "type": person.type.id.toString(),
    "name": person.name,
    "contactDate": person.contactDate.toString(),
    "contactDescription": person.contactDescription,
    "projects": person.projects,
    "webPage": person.webPage,
    "email": person.email,
    "phone": person.phone,
    "notes": person.notes,
  });

  var response = await client.post(createPersonUri(),
      headers: {"Content-Type": "application/json"}, body: bodyEncoded);

  print(response.statusCode);
  if (response.statusCode == 200) {
    int id = int.parse(json.decode((response).body)['id']);
    return id;
  }
  return 0;
}

///Modifica una persona
///
///Se pasa como parametro el person modificado [person]. Sus campos se crean en un body json. Después llamamos al endpoint gracias a la URI updatePersonUri de helpers/urls, al que le pasamos el id del person a modificar. Retorna true si la operación se completa exitosamente (codigo de respuesta == 200) y false en caso contrario.
Future<bool> updatePerson(Person person) async {
  Client client = http.Client();
  var bodyEncoded = jsonEncode({
    "type": person.type.id.toString(),
    "name": person.name,
    "contactDate": person.contactDate.toString(),
    "contactDescription": person.contactDescription,
    "projects": person.projects,
    "webPage": person.webPage,
    "email": person.email,
    "phone": person.phone,
    "notes": person.notes,
  });

  var response = await client.put(updatePersonUri(person.id.toString()),
      headers: {"Content-Type": "application/json"}, body: bodyEncoded);

  if (response.statusCode == 200) {
    return true;
  }
  return false;
}

///Elimina una persona
///
///Se pasa como parametro el id del person a eliminar [id]. Llamamos al endpoint gracias a la URI deletePersonUri de helpers/urls, al que le pasamos el id del person a eliminar. Retorna true si la operación se completa exitosamente (codigo de respuesta == 200) y false en caso contrario.
Future<bool> deletePerson(int id) async {
  Client client = http.Client();
  var response = await client.get(deletePersonUri(id.toString()),
      headers: {"Content-Type": "application/json"});
  if (response.statusCode == 200) {
    print("Person eliminated correctly 200");
    return true;
  }else{
  return false;
}
}


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
    DateTime castingDate = DateTime.parse(casting['castingDate']);
    String name = casting['name'];
    //Los id empiezan desde 1, pero las posiciones de una lista desde 0. Por eso, para asignar un director de casting se resta 1 al id, para obtener su posición en la lista
    Person castingDirector = peopleList[casting['castingDirector'] - 1];
    Person director = peopleList[casting['director'] - 1];
    bool inPerson = casting['inPerson'];
    bool inProcess = casting['inProcess'];
    String notes = casting['notes'];

    castings.add(Casting(
      id,
      castingDate,
      name,
      castingDirector,
      director,
      inPerson,
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
    "castingDate": casting.castingDate.toString(),
    "name": casting.name,
    "castingDirector": casting.castingDirector.id.toString(),
    "director": casting.director.id.toString(),
    "inPerson": casting.inPerson,
    "inProcess": casting.inProcess,
    "notes": casting.notes,
  });

  var response = await client.post(createCastingUri(),
      headers: {"Content-Type": "application/json"}, body: bodyEncoded);

  
  print(response.statusCode);
  if (response.statusCode == 200 || response.statusCode == 422) {
    print('response 200 Create Casting');
    int id = int.parse(json.decode((response).body)['id']);
    return id;
  }else{
    print('Error in Create Casting');
    print(response.statusCode);
  }
  return 0;
}

///Modifica un casting
///
///Se pasa como parametro el casting modificado [casting]. Sus campos se crean en un body json. Después llamamos al endpoint gracias a la URI updateCastingUri de helpers/urls, al que le pasamos el id del casting a modificar. Retorna true si la operación se completa exitosamente (codigo de respuesta == 200) y false en caso contrario.
Future<bool> updateCasting(Casting casting) async {
  Client client = http.Client();
  var bodyEncoded = jsonEncode({
    "castingDate": casting.castingDate.toString(),
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
  }else{
    print('Error in Update Casting');
    print(response.statusCode);
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
    print("Casting deleted correctly");
    return true;
  }else{
    print("Error castin deleting");
    print(response.statusCode);
    return false;
  }
}


/// Obtiene todos los companys de la base de datos
///
/// Hace una llamada al endpoint gracias a la URI de helpers/urls allCompanys, que nos devuelve una Future List de los companys. Es una Future List debido a que, al ser una llamada a la API, la data no se obtiene de manera inmediata. Por cada elemento de la respuesta, creamos un company y lo añadimos a [companys], que es lo que retornamos.
Future<List<Company>> getCompanys() async {
  Client client = http.Client();

  List<Company> companys = [];

  List response = json.decode((await client.get(allCompanys())).body);

  for (var company in response) {
    int id = int.parse(company['id']);
    String name = company['name'];

    companys.add(Company(
      id,
      name,
    ));
  }
  return companys;
}


/// Crea un company
///
/// Se nos pasa como parametro el company a crear [company]. Sus campos se crean en un body json. Después llamamos al endpoint gracias a la URI createCompanyUri de helpers/urls. Retorna el ID del company creado si la acción se completa correctamente (status code == 200), y 0 en caso contrario (ya que los ids empiezan en 1, no existe el ID 0. Si se retorna este valor, sabremos que se ha producido un error y no realizaremos la acción).
Future<int> createCompany(Company company) async {
  Client client = http.Client();
  var bodyEncoded = jsonEncode({
    "name": company.name,
  });

  var response = await client.post(createCompanyUri(),
      headers: {"Content-Type": "application/json"}, body: bodyEncoded);

  if (response.statusCode == 200) {
    int id = int.parse(json.decode((response).body)['id']);
    return id;
  }
  return 0;
}

///Modifica un company
///
///Se pasa como parametro el company modificado [company]. Sus campos se crean en un body json. Después llamamos al endpoint gracias a la URI updateCompanyUri de helpers/urls, al que le pasamos el id del company a modificar. Retorna true si la operación se completa exitosamente (codigo de respuesta == 200) y false en caso contrario.
Future<bool> updateCompany(Company company) async {
  Client client = http.Client();
  var bodyEncoded = jsonEncode({
    "name": company.name,
  });

  var response = await client.put(updateCompanyUri(company.id.toString()),
      headers: {"Content-Type": "application/json"}, body: bodyEncoded);

  if (response.statusCode == 200) {
    return true;
  }
  return false;
}

///Elimina un company
///
///Se pasa como parametro el id del company a eliminar [id]. Llamamos al endpoint gracias a la URI deleteCompanyUri de helpers/urls, al que le pasamos el id del company a eliminar. Retorna true si la operación se completa exitosamente (codigo de respuesta == 200) y false en caso contrario.
Future<bool> deleteCompany(int id) async {
  Client client = http.Client();

  var response = await client.get(deleteCompanyUri(id.toString()),
      headers: {"Content-Type": "application/json"});

  if (response.statusCode == 200) {
    return true;
  }
  return false;
}

/// Obtiene todos los activityTypes de la base de datos
///
/// Hace una llamada al endpoint gracias a la URI de helpers/urls allActivityTypes, que nos devuelve una Future List de los ActivityTypes. Es una Future List debido a que, al ser una llamada a la API, la data no se obtiene de manera inmediata. Por cada elemento de la respuesta, creamos un activityType y lo añadimos a [activityTypes], que es lo que retornamos.
Future<List<ActivityType>> getActivityTypes() async {
  Client client = http.Client();

  List<ActivityType> activityTypes = [];

  List response = json.decode((await client.get(allActivityTypes())).body);

  for (var activityType in response) {
    int id = int.parse(activityType['id']);
    String name = activityType['name'];

    activityTypes.add(ActivityType(
      id,
      name,
    ));
  }
  return activityTypes;
}



/// Obtiene todos los activities de la base de datos
///
/// Hace una llamada al endpoint gracias a la URI de helpers/urls allActivities, que nos devuelve una Future List de los activities. Es una Future List debido a que, al ser una llamada a la API, la data no se obtiene de manera inmediata. Por cada elemento de la respuesta, creamos un activity y lo añadimos a [activities], que es lo que retornamos.
Future<List<Activity>> getActivities(
  List<ActivityType> activityTypesList, List<Company> companysList) async {
  Client client = http.Client();

  List<Activity> activities = [];

  List<dynamic> response = json.decode((await client.get(allActivities())).body);

  for (var activity in response) {
    int id = int.parse(activity['id']);
    ActivityType type = activityTypesList[activity['type'] - 1];
    DateTime activityDate = DateTime.parse(activity['activityDate']);
    String name = activity['name'];
    Company company = companysList[activity['company'] - 1];
    int hours = activity['hours'];
    int price = activity['price'];
    int iva = activity['iva'];
    bool invoice = activity['invoice'] as bool;
    bool getPaid = activity['getPaid'] as bool;
    String notes = activity['notes'];

    activities.add(Activity(
      id,
      type,
      activityDate,
      name,
      company,
      hours,
      price,
      iva,
      invoice,
      getPaid,
      notes,
    ));
  }
  return activities;
}


/// Crea un activity
///
/// Se nos pasa como parametro el activity a crear [activity]. Sus campos se crean en un body json. Después llamamos al endpoint gracias a la URI createActivityri de helpers/urls. Retorna el ID del activity creado si la acción se completa correctamente (status code == 200), y 0 en caso contrario (ya que los ids empiezan en 1, no existe el ID 0. Si se retorna este valor, sabremos que se ha producido un error y no realizaremos la acción).
Future<int> createActivity(Activity activity) async {
  Client client = http.Client();
  var bodyEncoded = jsonEncode({
    "type": activity.type.id.toString(),
    "activityDate": activity.activityDate.toString(),
    "name": activity.name,
    "company": activity.company.id.toString(),
    "hours": activity.hours.toString(),
    "price": activity.price.toString(),
    "iva": activity.iva.toString(),
    "invoice": activity.invoice,
    "getPaid": activity.getPaid,
    "notes": activity.notes,
  });

  var response = await client.post(createActivityUri(),
      headers: {"Content-Type": "application/json"}, body: bodyEncoded);

  print(response.statusCode);
  if (response.statusCode == 200) {
    int id = int.parse(json.decode((response).body)['id']);
    return id;
  }
  return 0;
}

///Modifica un activity
///
///Se pasa como parametro el activity modificado [activity]. Sus campos se crean en un body json. Después llamamos al endpoint gracias a la URI updateActivityUri de helpers/urls, al que le pasamos el id del activity a modificar. Retorna true si la operación se completa exitosamente (codigo de respuesta == 200) y false en caso contrario.
Future<bool> updateActivity(Activity activity) async {
  Client client = http.Client();
  var bodyEncoded = jsonEncode({
    "type": activity.type.id.toString(),
    "activityDate": activity.activityDate.toString(),
    "name": activity.name,
    "company": activity.company.id.toString(),
    "hours": activity.hours.toString(),
    "price": activity.price.toString(),
    "iva": activity.iva.toString(),
    "invoice": activity.invoice,
    "getPaid": activity.getPaid,
    "notes": activity.notes,
  });

  var response = await client.put(updateActivityUri(activity.id.toString()),
      headers: {"Content-Type": "application/json"}, body: bodyEncoded);
  print(response.statusCode);
  if (response.statusCode == 200) {
    return true;
  }
  return false;
}

///Elimina un activity
///
///Se pasa como parametro el id del activity a eliminar [id]. Llamamos al endpoint gracias a la URI deleteActivityUri de helpers/urls, al que le pasamos el id del activity a eliminar. Retorna true si la operación se completa exitosamente (codigo de respuesta == 200) y false en caso contrario.
Future<bool> deleteActivity(int id) async {
  Client client = http.Client();

  print("Estoy intentando borrar la actividad");

  var response = await client.get(deleteActivityUri(id.toString()),
      headers: {"Content-Type": "application/json"});

  print(response.statusCode);
  if (response.statusCode == 200) {
    return true;
  }
  return false;
}