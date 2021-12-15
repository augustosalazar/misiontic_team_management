import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:misiontic_team_management/domain/controller/authentication_controller.dart';
import 'package:misiontic_team_management/domain/controller/firestore_controller.dart';
import 'package:misiontic_team_management/domain/controller/theme_controller.dart';
import 'package:misiontic_team_management/ui/widgets/appbar.dart';
import 'package:misiontic_team_management/ui/widgets/group_widget.dart';
import 'package:misiontic_team_management/ui/widgets/sesion_widget.dart';

class ContentPage extends StatefulWidget {
  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  int _selectIndex = 0;
  AuthenticationController authenticationController = Get.find();
  final FirestoreController firestoreController = Get.find();
  final ThemeController themeController = Get.find();
  static final List<Widget> _widgets = <Widget>[
    const GroupWidget(),
    SesionWidget()
  ];

  _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  _logout() async {
    try {
      await authenticationController.logOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    firestoreController.suscribeUpdates();
    super.initState();
  }

  @override
  void dispose() {
    firestoreController.unsuscribeUpdates();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        controller: themeController,
        tile: Text("Welcome ${authenticationController.userEmail()}"),
        context: context,
        onLogout: () {
          _logout();
        },
      ),
      body: _widgets.elementAt(_selectIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.groups_outlined,
              key: ValueKey("groupsTab"),
            ),
            label: "Groups",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.more_time_outlined,
                key: ValueKey("sesionsTab"),
              ),
              label: "Sesions")
        ],
        currentIndex: _selectIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
