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

/// Crea la URI al endpoint de update person
///
/// Retorna la URI correspondiente [updatePerson]
Uri updatePersonUri(String id) {
  Uri updatePerson = Uri.http('127.0.0.1:8000', '/people/update/$id');
  return (updatePerson);
}

/// Crea la URI al endpoint de create person
///
/// Retorna la URI correspondiente [createPerson]
Uri createPersonUri() {
  Uri createPerson = Uri.http('127.0.0.1:8000', '/people');
  return (createPerson);
}

/// Crea la URI al endpoint de delete person
///
/// Se pasa por parametro el id del person a eliminar [id]. Retorna la URI correspondiente [deletePerson]
Uri deletePersonUri(String id) {
  print("Estoy en la URI");
  Uri deletePerson = Uri.http('127.0.0.1:8000', '/people/delete/$id');
  print("Estoy en URI 2"+deletePerson.toString());
  return (deletePerson);
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


/// Crea la URI al endpoint de get all companys
///
/// Retorna la URI correspondiente [allCompanys]
Uri allCompanys() {
  Uri allCompanys = Uri.http('127.0.0.1:8000', '/companys');
  return (allCompanys);
}


/// Crea la URI al endpoint de update company
///
/// Retorna la URI correspondiente [updateCompany]
Uri updateCompanyUri(String id) {
  Uri updateCompany = Uri.http('127.0.0.1:8000', '/companys/update/$id');
  return (updateCompany);
}

/// Crea la URI al endpoint de create company
///
/// Retorna la URI correspondiente [createCompany]
Uri createCompanyUri() {
  Uri createCompany = Uri.http('127.0.0.1:8000', '/companys');
  return (createCompany);
}

/// Crea la URI al endpoint de delete company
///
/// Se pasa por parametro el id del company a eliminar [id]. Retorna la URI correspondiente [deleteCompany]
Uri deleteCompanyUri(String id) {
  Uri deleteCompany = Uri.http('127.0.0.1:8000', '/companys/delete/$id');
  return (deleteCompany);
}

/// Crea la URI al endpoint de get all ActivityTypes
///
/// Retorna la URI correspondiente [allActivityTypes]
Uri allActivityTypes() {
  Uri allActivityTypes = Uri.http('127.0.0.1:8000', '/activityTypes');
  return (allActivityTypes);
}

/// Crea la URI al endpoint de get all activities
///
/// Retorna la URI correspondiente [allActivities]
Uri allActivities() {
  Uri allActivities = Uri.http('127.0.0.1:8000', '/activities');
  return (allActivities);
}

/// Crea la URI al endpoint de update activity
///
/// Retorna la URI correspondiente [updateActivity]
Uri updateActivityUri(String id) {
  Uri updateActivity = Uri.http('127.0.0.1:8000', '/acitivites/update/$id');
  return (updateActivity);
}

/// Crea la URI al endpoint de create activity
///
/// Retorna la URI correspondiente [createActivity]
Uri createActivityUri() {
  Uri createActivity = Uri.http('127.0.0.1:8000', '/activities');
  return (createActivity);
}

/// Crea la URI al endpoint de delete activity
///
/// Se pasa por parametro el id del activity a eliminar [id]. Retorna la URI correspondiente [deleteActivity]
Uri deleteActivityUri(String id) {
  Uri deleteActivity = Uri.http('127.0.0.1:8000', '/activites/delete/$id');
  return (deleteActivity);
}