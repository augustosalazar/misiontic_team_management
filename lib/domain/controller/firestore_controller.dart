import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:misiontic_team_management/data/model/group.dart';
import 'package:misiontic_team_management/data/model/sesion.dart';

class FirestoreController extends GetxController {
  var _groups = <Group>[].obs;
  var _sesions = <Sesion>[].obs;

  final CollectionReference groupCollectionReference =
      FirebaseFirestore.instance.collection('groups');
  final Stream<QuerySnapshot> _gruopStream = FirebaseFirestore.instance
      .collection('groups')
      .orderBy('groupId')
      .snapshots();
  late StreamSubscription<Object?> groupStreamSubscription;

  final CollectionReference sesionCollectionReference =
      FirebaseFirestore.instance.collection('sesions');
  final Stream<QuerySnapshot> _sesionStream = FirebaseFirestore.instance
      .collection('sesions')
      .orderBy('date')
      .snapshots();
  late StreamSubscription<Object?> sesionStreamSubscription;

  suscribeUpdates() async {
    logInfo('suscribeLocationUpdates');
    groupStreamSubscription = _gruopStream.listen((event) {
      logInfo('Got new item from fireStore');
      _groups.clear();
      for (var element in event.docs) {
        _groups.add(Group.fromSnapshot(element));
      }
      logInfo('Got grups ${_groups.length}');
    });

    sesionStreamSubscription = _sesionStream.listen((event) {
      logInfo('Got new item from fireStore');
      _sesions.clear();
      for (var element in event.docs) {
        _sesions.add(Sesion.fromSnapshot(element));
      }
      logInfo('Got grups ${_groups.length}');
    });
  }

  unsuscribeUpdates() {
    groupStreamSubscription.cancel();
    sesionStreamSubscription.cancel();
  }

  List<Group> get groups => _groups;
  List<Sesion> get sesions => _sesions;

  List<String> groupIds() {
    List<String> list = [];
    for (var element in _groups) {
      list.add('Grupo ' + element.groupId.toString());
    }
    return list;
  }

  addGoup(groupId, student1, student2) {
    groupCollectionReference
        .add({
          'groupId': groupId,
          'student1': student1,
          'student2': student2,
        })
        .then((value) => logInfo("Group added"))
        .catchError((onError) => logError("Failed to add baby $onError"));
  }

  addSesion(groupId, student1, student2) {
    sesionCollectionReference
        .add({
          'date': DateTime.now(),
          'groupId': groupId,
          'student1': student1,
          'student2': student2,
        })
        .then((value) => logInfo("Sesion added"))
        .catchError((onError) => logError("Failed to add baby $onError"));
  }
}
