/// Crea la URI al endpoint de get all personTypes
///
/// Retorna la URI correspondiente [allPersonTypes]
Uri allPersonTypes() {
  Uri allPersonTypes = Uri.http('127.0.0.1:8000', '/personTypes');
  return (allPersonTypes);
}



/// Crea la URI al endpoint de get all people
///
/// Retorna la URI correspondiente [allPeople]
Uri allPeople() {
  Uri allPeople = Uri.http('127.0.0.1:8000', '/people');
  return (allPeople);
}


/// Crea la URI al endpoint de get all castings
///
/// Retorna la URI correspondiente [allCastings]
Uri allCastings() {
  Uri allCastings = Uri.http('127.0.0.1:8000', '/castings');
  return (allCastings);
}


/// Crea la URI al endpoint de update castings
///
/// Retorna la URI correspondiente [updateCasting]
Uri updateCastingUri(String id) {
  Uri updateCasting = Uri.http('127.0.0.1:8000', '/castings/update/$id');
  return (updateCasting);
}

/// Crea la URI al endpoint de create casting
///
/// Retorna la URI correspondiente [createCasting]
Uri createCastingUri() {
  Uri createCasting = Uri.http('127.0.0.1:8000', '/castings');
  return (createCasting);
}

/// Crea la URI al endpoint de delete casting
///
/// Se pasa por parametro el id del casting a eliminar [id]. Retorna la URI correspondiente [deleteCasting]
Uri deleteCastingUri(String id) {
  Uri deleteCasting = Uri.http('127.0.0.1:8000', '/castings/delete/$id');
  return (deleteCasting);
}
