import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//import '../blocs/auth_bloc.dart';
import '../blocs/create_task_bloc.dart';

class MyCheckBox extends StatefulWidget {
  //final bool isCheck = false;
  final VoidCallback onChanged;

  const MyCheckBox({required this.onChanged});
  @override
  createState() => new MyCheckBoxState();
}

class MyCheckBoxState extends State<MyCheckBox> {
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: isCheck,
        onChanged: (newBool) {
          setState(() {
            isCheck = !isCheck;
          });
          widget.onChanged();
        });
  }
}
