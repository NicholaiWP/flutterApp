class InfoData {
  String id;
  String name;
  String computerModel;
  int yearOfBirth;

  InfoData(this.id, this.name, this.computerModel, this.yearOfBirth);

  InfoData.map(dynamic obj) {
    this.id = obj['id'];
    this.name = obj['name'];
    this.computerModel = obj['computerModel'];
    this.yearOfBirth = obj['yearOfBirth'];
  }
  String get myId => id;
  String get myName => name;
  String get myComputerModel => computerModel;
  int get myAge => yearOfBirth;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['name'] = name;
    map['computerModel'] = computerModel;
    map['yearOfBirth'] = yearOfBirth;

    return map;
  }

  InfoData.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.computerModel = map['computerModel'];
    this.yearOfBirth = map['yearOfBirth'];
  }
}