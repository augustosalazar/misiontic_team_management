import 'package:cloud_firestore/cloud_firestore.dart';

class Group {
  final String groupId;
  final String student1;
  final String student2;
  final DocumentReference? reference;

  Group(this.groupId, this.student1, this.student2, this.reference);

  Group.fromMap(Map<String, dynamic> map, {required this.reference})
      : assert(map['groupId'] != null),
        assert(map['student1'] != null),
        assert(map['student2'] != null),
        groupId = map['groupId'],
        student1 = map['student1'],
        student2 = map['student2'];

  Group.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>,
            reference: snapshot.reference);

  @override
  String toString() => "Group<$groupId:$student1:$student2>";
}
