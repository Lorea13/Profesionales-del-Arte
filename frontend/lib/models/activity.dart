import 'package:frontend/models/activityType.dart';
import 'package:frontend/models/company.dart';

class Activity {
  int id;
  ActivityType type;
  DateTime activityDate;
  String name;
  Company company;
  int hours;
  int price;
  int iva;
  bool invoice;
  bool getPaid;
  String notes;

  Activity(
      this.id, this.type, this.activityDate, this.name, this.company, this.hours, this.price, this.iva, this.invoice, this.getPaid, this.notes);
}
