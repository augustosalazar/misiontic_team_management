import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:misiontic_team_management/domain/controller/firestore_controller.dart';

class AddSesionPage extends StatefulWidget {
  const AddSesionPage({Key? key}) : super(key: key);

  @override
  State<AddSesionPage> createState() => _AddSesionPageState();
}

class _AddSesionPageState extends State<AddSesionPage> {
  final FirestoreController firebaseController = Get.find();
  late List<String> groupIds;
  late String _selectedGroupId;
  bool student1 = false;
  bool student2 = false;

  @override
  void initState() {
    groupIds = firebaseController.groupIds();
    setState(() {
      _selectedGroupId = groupIds[0];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add sesion'),
      ),
      body: Column(
        children: [
          DropdownButton<String>(
            key: const ValueKey("sesionDrop"),
            value: _selectedGroupId,
            items: groupIds.map((String val) {
              return DropdownMenuItem<String>(
                key: ValueKey(val),
                value: val,
                child: Text(val),
              );
            }).toList(),
            hint: const Text("Please choose a group"),
            onChanged: (value) {
              setState(() {
                _selectedGroupId = value!;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('Student 1'),
              Switch(
                key: const ValueKey("sesionUser1"),
                value: student1,
                onChanged: (value) {
                  setState(() {
                    student1 = value;
                  });
                },
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('Student 2'),
              Switch(
                key: const ValueKey("sesionUser2"),
                value: student2,
                onChanged: (value) {
                  setState(() {
                    student2 = value;
                  });
                },
              )
            ],
          ),
          ElevatedButton(
              key: const ValueKey("actionSesion"),
              onPressed: () {
                // TODO
                logInfo(
                    'Aquí llamar al método addSesion del firebaseController');
                Get.back();
              },
              child: const Text('Save sesion'))
        ],
      ),
    );
  }
}
