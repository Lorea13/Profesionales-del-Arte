import 'package:flutter/material.dart';

import 'package:frontend/models/personType.dart';
import 'package:frontend/models/person.dart';
import 'package:frontend/models/casting.dart';
import 'package:frontend/models/company.dart';
import 'package:frontend/models/activityType.dart';
import 'package:frontend/models/activity.dart';

import 'package:google_fonts/google_fonts.dart';

import '../helpers/methods.dart';
import 'home.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  bool _isLoading = true;

    List<PersonType> personTypes = [];
    List<Person> people = [];
    List<Casting> castings = [];

  /// Obtención de los datos
  ///
  /// Este método llama a 6 métodos, uno por cada tabla de la base de datos, para obtener toda la información que haya. Cada método hará una petición a la API. Después espera 10 segundos, y cambia la variable isLoading a false, con lo que indicará que se ha cargado toda la info correctamente y saldrá de la página de carga
  obtainDataApi() async {
    await obtainPersonTypes();
    await obtainPeople();
    await obtainCastings();

    await Future.delayed(const Duration(seconds: 10));

    setState(() {
      _isLoading = false;
    });
  }

  ///Obtiene todos los tipos de persona
  ///
  ///Llama al método de /helpers/methods getPersonTypes, que nos retorna una lista de los tipos de personas, futurePersonType. Es un Future List porque, al ser una petición API, no se obtendrá respuesta al momento. Retorna dicha lista de tipos de personas [personTypes] que contendrá todos los tipos de personas de la base de datos.
  obtainPersonTypes() async {
    Future<List<PersonType>> futurePersonTypes = getPersonTypes();

    personTypes = await futurePersonTypes;
  }

  ///Obtiene todas las personas
  ///
  ///Llama al método de /helpers/methods getPeople, que nos retorna una lista de personas, futurePeople. Es un Future List porque, al ser una petición API, no se obtendrá respuesta al momento. Retorna dicha lista de personas [people] que contendrá todas las personas de la base de datos.
  obtainPeople() async {
    Future<List<Person>> futurePeople = getPeople(personTypes);

    people = await futurePeople;
  }

  ///Obtiene todas los castings
  ///
  ///Llama al método de /helpers/methods getCastings, que nos retorna una lista de castings, futureCastings. Es un Future List porque, al ser una petición API, no se obtendrá respuesta al momento. Retorna dicha lista de castings [castings] que contendrá todos los castings de la base de datos.
  obtainCastings() async {
    Future<List<Casting>> futureCastings = getCastings(people);

    castings = await futureCastings;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      obtainDataApi();
    }

    return Scaffold(
      body: _isLoading
          ? Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    "images/logo.png",
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.12,
                      width: MediaQuery.of(context).size.width * 0.12,
                      child: Image.asset(
                        "gifs/theatre.gif",
                      ),
                    ),
                    Text('¡Que comience el espectáculo! . . .',
                        style: GoogleFonts.basic(
                            fontSize:
                                MediaQuery.of(context).size.width / 1000 * 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ]))
          : Home(personTypes, people, castings),
    );
  }
}