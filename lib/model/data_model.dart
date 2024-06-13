import 'dart:typed_data';

class StudentModel {
  int? id;
  String name;
  String? course;
  String? adno;
  String? contact;
  String? guardian;
  Uint8List? img;

  StudentModel({
    required this.id,
    required this.name,
    required this.course,
    required this.adno,
    required this.contact,
    required this.guardian,
    required this.img,
  });
  static StudentModel fromMap(Map<String, Object?> map) {
    final id = map['id'] as int;
    final name = map['name'] as String;
    final course = map['course'] as String;
    final adno = map['adno'].toString();
    final contact = map['contact'].toString();
    final guardian = map['guardian'].toString();
    final img = map['img'] as Uint8List;

    return StudentModel(
        id: id,
        name: name,
        course: course,
        adno: adno,
        contact: contact,
        guardian: guardian,
        img: img);
  }
}
