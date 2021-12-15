import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:misiontic_team_management/data/model/group.dart';
import 'package:misiontic_team_management/data/model/sesion.dart';
import 'package:misiontic_team_management/domain/controller/firestore_controller.dart';
import 'package:misiontic_team_management/ui/widgets/group_widget.dart';
import 'package:misiontic_team_management/ui/widgets/sesion_widget.dart';
import 'package:mockito/mockito.dart';

class MockFirestoreController extends GetxService
    with Mock
    implements FirestoreController {
  var _groups = <Group>[].obs;
  var _sesions = <Sesion>[].obs;

  @override
  List<Group> get groups => _groups;
  @override
  List<Sesion> get sesions => _sesions;

  @override
  addGoup(groupId, student1, student2) {
    _groups.add(Group(groupId, student1, student2, null));
  }

  @override
  addSesion(groupId, student1, student2) {
    _sesions.add(Sesion(Timestamp.now(), groupId, student1, student2, null));
  }
}

void main() {
  setUp(() {
    MockFirestoreController mockFirestoreController = MockFirestoreController();
    Get.put<FirestoreController>(mockFirestoreController);
  });
  testWidgets('Group test', (WidgetTester tester) async {
    final groupField = find.byKey(const ValueKey("groupId"));
    final student1Field = find.byKey(const ValueKey("groupUser1"));
    final student2Field = find.byKey(const ValueKey("groupUser2"));
    final groupAction = find.byKey(const ValueKey("groupAction"));
    final groupCard = find.byKey(const ValueKey("groupCard"));

    await tester.pumpWidget(const GetMaterialApp(
        home: Scaffold(
      body: GroupWidget(),
    )));

    await tester.pump();

    expect(find.byKey(const ValueKey("groupsScaffold")), findsOneWidget);
    expect(find.byKey(const ValueKey("addGroupAction")), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey("addGroupAction")));

    await tester.pumpAndSettle();

    expect(groupField, findsOneWidget);
    expect(student1Field, findsOneWidget);
    expect(student2Field, findsOneWidget);
    expect(groupAction, findsOneWidget);

    await tester.enterText(groupField, "-test");
    await tester.enterText(student1Field, "Student1-Test");
    await tester.enterText(student2Field, "Student1-Test");
    await tester.tap(groupAction);

    await tester.pumpAndSettle();

    expect(groupCard, findsWidgets);
  });
}
