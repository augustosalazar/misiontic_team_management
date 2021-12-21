import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:misiontic_team_management/config/config.dart';
import 'package:misiontic_team_management/domain/controller/authentication_controller.dart';
import 'package:misiontic_team_management/domain/controller/firestore_controller.dart';
import 'package:misiontic_team_management/domain/controller/theme_controller.dart';
import 'package:misiontic_team_management/domain/theme_management.dart';
import 'package:misiontic_team_management/ui/theme/theme.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'firebase_central.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<FirebaseApp> _initialization;
    if (kIsWeb) {
      _initialization = Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: Configurations.apiKey,
            authDomain: Configurations.authDomain,
            databaseURL: Configurations.databaseURL,
            projectId: Configurations.projectId,
            storageBucket: Configurations.storageBucket,
            messagingSenderId: Configurations.messagingSenderId,
            appId: Configurations.apiKey,
            measurementId: Configurations.measurementId),
      );
    } else {
      _initialization = Firebase.initializeApp();
    }
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
            logError("error ${snapshot.error}");
            return const Wrong();
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
  const Wrong({Key? key}) : super(key: key);

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
