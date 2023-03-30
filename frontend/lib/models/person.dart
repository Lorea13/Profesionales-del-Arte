import 'package:frontend/models/personType.dart';

class Person {
  int id;
  PersonType type;
  String name;
  Date contactDate;
  String contactDescription;
  String projects;
  String webPage;
  String email;
  String phone;
  String notes;

  Person(
      this.id, this.type, this.name, this.contactDate, this.contactDescription, this.projects, this.webPage, this.email, this.phone, this.notes);
}
