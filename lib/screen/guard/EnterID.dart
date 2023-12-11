import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swiftcheckin/dataModels/guard.dart';
import 'package:swiftcheckin/dataModels/student.dart';
import 'package:swiftcheckin/screen/error/InvalidID.dart';
import 'package:swiftcheckin/screen/guard/validata.dart';
import 'package:swiftcheckin/services/dataServices.dart';

class EnterID extends StatefulWidget {
  EnterID({Key? key, required this.guardObject}) : super(key: key);
  guard? guardObject;

  @override
  State<EnterID> createState() => _Feature1State();
}

class _Feature1State extends State<EnterID> {
  final TextEditingController _textController = TextEditingController();
  String userPost = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter ID"),
        backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextField(
            controller: _textController,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: InputDecoration(
                hintText: "Enter Roll",
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _textController.clear();
                  },
                )),
          ),
          const SizedBox(height: 45),
          ElevatedButton(
            onPressed: () async {
              userPost = _textController.text;
              var ID = int.parse(userPost);
              student? obj = await dataServices.fetchDetailsOfStudentID(ID);
              if (!context.mounted) {
                return;
              }
              if (obj != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => ValidatePage(
                          guardObject: widget.guardObject,
                          studentObject: obj,
                        )),
                  ),
                );
              } else {
                print("Invalid ID");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => const errorInvalidID()),
                  ),
                );
              }
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.cyan)),
            child: const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  'Validate',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                )),
          )
        ]),
      ),
    );
  }
}
