import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/data/taskchangenotifier.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String newTask;
    return Container(
      height: MediaQuery.of(context).viewInsets.bottom + 210,
      padding: EdgeInsets.only(top: 30, right: 30, left: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Add Task',
            textAlign: TextAlign.center,
            style: GoogleFonts.openSans(
              color: Theme.of(context).disabledColor,
              fontSize: 30.0,
            ),
          ),
          TextField(
            controller: _controller,
            textCapitalization: TextCapitalization.sentences,
            style: TextStyle(color: Theme.of(context).primaryColor),
            decoration: InputDecoration(
              hintText: "Enter your task here",
              hintStyle: TextStyle(color: Theme.of(context).highlightColor),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).disabledColor),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).disabledColor),
              ),
            ),
            cursorColor: Theme.of(context).disabledColor,
            onChanged: (String value) {
              newTask = value;
            },
            onSubmitted: (value) {
              if (!(value?.trim()?.isEmpty ?? true)) {
                Provider.of<TaskChangeNotifier>(context, listen: false)
                    .add(value);
                Navigator.pop(context);
              }
              
            },
            autofocus: true,
          ),
          SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () {
              if (!(newTask?.trim()?.isEmpty ?? true)) {
                Provider.of<TaskChangeNotifier>(context, listen: false)
                    .add(newTask);
                Navigator.pop(context);
              }
              else if(_controller.text.isNotEmpty){
                Provider.of<TaskChangeNotifier>(context, listen: false)
                    .add(_controller.text);
                Navigator.pop(context);
              }
            },
            child: Text(
              'Add',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
