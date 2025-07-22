class studentModel {
  final int id;
  final String name;
  final int age;

  studentModel({required this.id, required this.name, required this.age});
  Map<String, dynamic> toMap() {
    return {"id": id, "name": name, "age": age};
  }

  factory studentModel.fromMap(Map<String, dynamic> map) {
    return studentModel(id: map["id"], name: map["name"], age: map["age"]);
  }
}
