class Company {
  int id;
  String name;

  static Company empty() {
    return Company(0, "");
  }

  Company(
      this.id, this.name);
}


