import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:misiontic_team_management/domain/controller/authentication_controller.dart';
import 'package:misiontic_team_management/domain/controller/firestore_controller.dart';
import 'package:misiontic_team_management/domain/controller/theme_controller.dart';
import 'package:misiontic_team_management/domain/theme_management.dart';
import 'package:misiontic_team_management/ui/theme/theme.dart';

import 'firebase_central.dart';

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase demo - MisionTIC',
      theme: MyTheme.ligthTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: Scaffold(
          body: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("error ${snapshot.error}");
            return Wrong();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Get.put(FirestoreController());
            Get.put(AuthenticationController());
            final ThemeController controller = Get.put(ThemeController());
            late final ThemeManager manager = ThemeManager();
            Future<void> initializeTheme() async {
              controller.darkMode = await manager.storedTheme;
            }

            ever(controller.reactiveDarkMode, (bool isDarkMode) {
              manager.changeTheme(isDarkMode: isDarkMode);
            });
            initializeTheme();
            return FirebaseCentral();
          }

          return const Loading();
        },
      )),
    );
  }
}

class Wrong extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Something went wrong"));
  }
}

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Loading"));
  }
}
