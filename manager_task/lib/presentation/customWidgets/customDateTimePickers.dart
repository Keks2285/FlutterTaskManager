import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

//import '../blocs/auth_bloc.dart';
import '../blocs/create_task_bloc.dart';

class MyDateTimePicker extends StatefulWidget {
  //final bool isCheck = false;
  final VoidCallback onChanged;
  final String finalString=DateFormat("yyyy-MM-dd").format(DateTime.now().add(Duration(days: 1)))+" "+TimeOfDay.now().hour.toString()+" "+TimeOfDay.now().minute.toString()+":00";
   MyDateTimePicker({required this.onChanged});
  @override
  createState() => new MyDateTimePickerState();
}

class MyDateTimePickerState extends State<MyDateTimePicker> {

  DateTime selectedDateTime = DateTime.now().add(Duration(days: 1));
  TimeOfDay selectedTime = TimeOfDay(hour: 0, minute: 0);
  String finalString=DateFormat("yyyy-MM-dd").format(DateTime.now().add(Duration(days: 1)))+" "+TimeOfDay.now().hour.toString()+" "+TimeOfDay.now().minute.toString()+":00";
  Future<void> _showPicker(BuildContext context) async {
      await showDatePicker(
              context: context,
              initialDate: selectedDateTime,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(Duration(days: 1095)))
          .then((value) => {selectedDateTime = value ?? selectedDateTime})
          .then((value) => {});
      selectedTime = await showTimePicker(
              context: context, initialTime: TimeOfDay.now()) ??
          selectedTime;
    }

  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    return 
    Row(
      children: [
        Text(finalString),
        IconButton(
                        alignment: Alignment.centerRight,
                        icon: Icon(Icons.calendar_month_sharp),
                        onPressed: () {
                          setState(() {
                          _showPicker(context).then((value) {
                            finalString=DateFormat("yyyy-MM-dd").format(selectedDateTime)+" "+selectedTime.hour.toString()+" "+selectedTime.minute.toString()+":00";
                            });
                            //MyDateTimePicker.finalString=finalString;
                          });
                           widget.onChanged();
                        },
                      )
      ],
    );
                      
  }
}