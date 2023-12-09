import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swiftcheckin/dataModels/guard.dart';
import 'package:swiftcheckin/dataModels/student.dart';
import 'package:swiftcheckin/screen/guard/validata.dart';
import 'package:swiftcheckin/services/dataServices.dart';

class Feature1 extends StatefulWidget {
  Feature1({Key? key, required this.guardObject}) : super(key: key);
  guard guardObject;

  @override
  State<Feature1> createState() => _Feature1State();
}

class _Feature1State extends State<Feature1> {
  final TextEditingController _textController = TextEditingController();
  String userPost = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hello")),
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
          MaterialButton(
            onPressed: () async {
              userPost = _textController.text;
              var ID = int.parse(userPost);
              student? obj = await dataServices.fetchDetailsOfStudentID(ID);
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
              }
            },
            color: Colors.blue,
            child: const Text(
              'Post',
              style: TextStyle(color: Colors.white),
            ),
          )
        ]),
      ),
    );
  }
}
