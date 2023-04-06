import 'package:frontend/models/person.dart';

class Casting {
  int id;
  DateTime castingDate;
  String name;
  Person castingDirector;
  Person director;
  bool inPerson;
  bool inProcess;
  String notes;

  Casting(
      this.id, this.castingDate, this.name, this.castingDirector, this.director, this.inPerson, this.inProcess, this.notes);
}
