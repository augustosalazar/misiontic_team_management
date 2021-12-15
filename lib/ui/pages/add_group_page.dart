import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:misiontic_team_management/domain/controller/firestore_controller.dart';

class AddGroupPage extends StatefulWidget {
  const AddGroupPage({Key? key}) : super(key: key);

  @override
  _AddGroupPageState createState() => _AddGroupPageState();
}

class _AddGroupPageState extends State<AddGroupPage> {
  final FirestoreController firebaseController = Get.find();
  final _formKey = GlobalKey<FormState>();
  final _groupIdController = TextEditingController();
  final _student1Controller = TextEditingController();
  final _student2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add group'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 12.0),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    key: const ValueKey("groupId"),
                    controller: _groupIdController,
                    decoration: const InputDecoration(labelText: 'Group Id'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter groupId";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    key: const ValueKey("groupUser1"),
                    controller: _student1Controller,
                    decoration: const InputDecoration(labelText: 'Student 1'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Student 1";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    key: const ValueKey("groupUser2"),
                    controller: _student2Controller,
                    decoration: const InputDecoration(labelText: 'Student 2'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Student 1";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  OutlinedButton(
                      key: const ValueKey("groupAction"),
                      onPressed: () {
                        // this line dismiss the keyboard by taking away the focus of the TextFormField and giving it to an unused
                        FocusScope.of(context).requestFocus(FocusNode());
                        final form = _formKey.currentState;
                        form!.save();
                        if (form.validate()) {
                          // TODO
                          logInfo(
                              'Aquí llamar al método addGroup del firebaseController');
                          Get.back();
                        }
                      },
                      child: const Text("Submit")),
                ],
              )),
        ),
      ),
    );
  }
}
