import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:misiontic_team_management/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    // It is assumed that the credential is already created:
    // a@a.com:123456

    late String groupId;

    setUp(() {
      groupId = DateTime.now().millisecondsSinceEpoch.toString();
      groupId += "-test";
    });

    testWidgets('group creation', (WidgetTester tester) async {
      final emailField = find.byKey(const ValueKey("loginEmail"));
      final passwordField = find.byKey(const ValueKey("loginPassword"));
      final loginAction = find.byKey(const ValueKey("loginAction"));

      final groupsScaffold = find.byKey(const ValueKey("groupsScaffold"));
      final groupCard = find.byKey(const ValueKey("groupCard"));
      final addGroupAction = find.byKey(const ValueKey("addGroupAction"));
      final logoutAction = find.byKey(const ValueKey("logoutAction"));

      final groupField = find.byKey(const ValueKey("groupId"));
      final student1Field = find.byKey(const ValueKey("groupUser1"));
      final student2Field = find.byKey(const ValueKey("groupUser2"));
      final groupAction = find.byKey(const ValueKey("groupAction"));

      app.main();
      await tester.pumpAndSettle();

      await tryLogout(logoutAction, tester);

      expect(emailField, findsOneWidget);
      expect(passwordField, findsOneWidget);
      expect(loginAction, findsOneWidget);

      await tester.enterText(emailField, "a@a.com");
      await tester.enterText(passwordField, "123456");
      await tester.tap(loginAction);

      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 1));

      expect(groupsScaffold, findsOneWidget);
      expect(addGroupAction, findsOneWidget);
      expect(logoutAction, findsOneWidget);

      await tester.tap(addGroupAction);

      await tester.pumpAndSettle();

      expect(groupField, findsOneWidget);
      expect(student1Field, findsOneWidget);
      expect(student2Field, findsOneWidget);
      expect(groupAction, findsOneWidget);

      await tester.enterText(groupField, groupId);
      await tester.enterText(student1Field, "Student1-Test");
      await tester.enterText(student2Field, "Student1-Test");
      await tester.tap(groupAction);

      await tester.pumpAndSettle();

      expect(groupCard, findsWidgets);

      await tester.tap(logoutAction);

      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 1));

      expect(loginAction, findsWidgets);
    });

    testWidgets('group and sesion creation', (WidgetTester tester) async {
      final emailField = find.byKey(const ValueKey("loginEmail"));
      final passwordField = find.byKey(const ValueKey("loginPassword"));
      final loginAction = find.byKey(const ValueKey("loginAction"));

      final groupsScaffold = find.byKey(const ValueKey("groupsScaffold"));
      final groupCard = find.byKey(const ValueKey("groupCard"));
      final sesionCard = find.byKey(const ValueKey("sesionCard"));
      final addGroupAction = find.byKey(const ValueKey("addGroupAction"));
      final addSesionAction = find.byKey(const ValueKey("addSesionAction"));
      final groupsTab = find.byKey(const ValueKey("groupsTab"));
      final sesionsTab = find.byKey(const ValueKey("sesionsTab"));
      final logoutAction = find.byKey(const ValueKey("logoutAction"));

      final groupField = find.byKey(const ValueKey("groupId"));
      final student1Field = find.byKey(const ValueKey("groupUser1"));
      final student2Field = find.byKey(const ValueKey("groupUser2"));
      final groupAction = find.byKey(const ValueKey("groupAction"));

      final sesionDrop = find.byKey(const ValueKey("sesionDrop"));
      final student1Switch = find.byKey(const ValueKey("sesionUser1"));
      final student2Switch = find.byKey(const ValueKey("sesionUser2"));
      final sesionAction = find.byKey(const ValueKey("actionSesion"));

      app.main();
      await tester.pumpAndSettle();

      await tryLogout(logoutAction, tester);

      expect(emailField, findsOneWidget);
      expect(passwordField, findsOneWidget);
      expect(loginAction, findsOneWidget);

      await tester.enterText(emailField, "a@a.com");
      await tester.enterText(passwordField, "123456");
      await tester.tap(loginAction);

      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 1));

      expect(groupsScaffold, findsOneWidget);
      expect(addGroupAction, findsOneWidget);
      expect(groupsTab, findsOneWidget);
      expect(sesionsTab, findsOneWidget);
      expect(logoutAction, findsOneWidget);

      await tester.tap(addGroupAction);

      await tester.pumpAndSettle();

      expect(groupField, findsOneWidget);
      expect(student1Field, findsOneWidget);
      expect(student2Field, findsOneWidget);
      expect(groupAction, findsOneWidget);

      await tester.enterText(groupField, groupId);
      await tester.enterText(student1Field, "Student1-Test");
      await tester.enterText(student2Field, "Student1-Test");
      await tester.tap(groupAction);

      await tester.pumpAndSettle();

      expect(groupCard, findsWidgets);

      await tester.tap(sesionsTab);

      await tester.pumpAndSettle();
      await tester.pump(const Duration(milliseconds: 500));

      await tester.tap(addSesionAction);

      await tester.pumpAndSettle();
      await tester.pump(const Duration(milliseconds: 500));

      expect(sesionDrop, findsOneWidget);
      expect(student1Switch, findsOneWidget);
      expect(student2Switch, findsOneWidget);
      expect(sesionAction, findsOneWidget);

      await tester.tap(sesionDrop);

      await tester.pumpAndSettle();
      await tester.pump(const Duration(milliseconds: 500));

      await tester.tap(find.byKey(ValueKey("Grupo $groupId")).last);

      await tester.pumpAndSettle();
      await tester.pump(const Duration(milliseconds: 500));

      await tester.tap(student1Switch);

      await tester.pumpAndSettle();
      await tester.pump(const Duration(milliseconds: 500));

      await tester.tap(student2Switch);

      await tester.pumpAndSettle();
      await tester.pump(const Duration(milliseconds: 500));

      await tester.tap(student1Switch);

      await tester.pumpAndSettle();
      await tester.pump(const Duration(milliseconds: 500));

      await tester.tap(sesionAction);

      await tester.pumpAndSettle();
      await tester.pump(const Duration(milliseconds: 500));

      expect(sesionCard, findsWidgets);

      await tester.tap(groupsTab);

      await tester.pumpAndSettle();
      await tester.pump(const Duration(milliseconds: 500));

      expect(groupCard, findsWidgets);

      await tester.tap(logoutAction);

      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 1));

      expect(loginAction, findsWidgets);
    });
  });
}

tryLogout(Finder finder, WidgetTester tester) async {
  try {
    await tester.tap(finder);
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 1));
    return true;
  } catch (exception) {
    return false;
  }
}
