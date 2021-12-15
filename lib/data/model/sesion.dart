import 'package:cloud_firestore/cloud_firestore.dart';

class Sesion {
  final Timestamp date;
  final String groupId;
  final bool student1;
  final bool student2;
  final DocumentReference? reference;

  Sesion(this.date, this.groupId, this.student1, this.student2, this.reference);

  Sesion.fromMap(Map<String, dynamic> map, {required this.reference})
      : assert(map['date'] != null),
        assert(map['groupId'] != null),
        assert(map['student1'] != null),
        assert(map['student2'] != null),
        date = map['date'],
        groupId = map['groupId'],
        student1 = map['student1'],
        student2 = map['student2'];

  Sesion.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>,
            reference: snapshot.reference);

  @override
  String toString() => "Sesion<$date:$groupId:$student1:$student2>";
}
