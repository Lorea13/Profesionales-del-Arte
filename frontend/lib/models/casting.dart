import 'package:frontend/models/person.dart';

class Casting {
  int id;
  Date date;
  String name;
  Person castingDirector;
  Person director;
  bool inPerson;
  bool inProcess;
  String notes;

  Casting(
      this.id, this.date, this.name, this.castingDirector, this.director, this.inPerson, this.inProcess, this.notes);
}
