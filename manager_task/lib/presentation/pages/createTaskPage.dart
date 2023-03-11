// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//import '../blocs/auth_bloc.dart';
import '../blocs/create_task_bloc.dart';

class CreateTaskPage extends StatelessWidget {
  final descriptionController = TextEditingController();
  DateTime selectedDateTime = DateTime.now().add(Duration(days: 1));
  TimeOfDay selectedTime = TimeOfDay(hour: 0, minute: 0);

  List<String> dropdownMenuItems = [
    "#Учеба",
    "#Дом",
    "#Работа",
    "#Семья",
    "#Другое",
  ];
//String? selectedItem = "#Учеба";
//CreateTaskPage({super.key});
  Future<void> _showPicker(BuildContext context) async {
    await showDatePicker(
                context: context,
                initialDate: selectedDateTime,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 1095)))
            .then((value) => {selectedDateTime = value ?? selectedDateTime})
            .then((value) => {
// showTimePicker(context: context, initialTime: TimeOfDay.now()).
                })
// .then((value) => {
// selectedTime = (value as TimeOfDay )
// })
        ;
    selectedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now()) ??
            selectedTime;
  }
//final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CreateTaskBloc(),
        child: BlocBuilder<CreateTaskBloc, CreateTaskBlocState>(
            builder: (context, state) {
          return Scaffold(
              backgroundColor: Color.fromARGB(255, 3, 158, 162),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
// ignore: prefer_interpolation_to_compose_strings
/////////////////////////////////////////

                  Container(
                    margin: EdgeInsets.fromLTRB(20, 50, 20, 20),
                    child: TextField(
                        minLines: 2,
                        maxLines: 10,
                        cursorWidth: 2,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Введите описание",
                        )),
                  ),
                  Container(
//color: Colors.black,
                      //margin: EdgeInsets.fromLTRB(20, 0, 0, 20),
                      //padding: EdgeInsets.fromLTRB(15, 0, 5, 0),
                      width: 220,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(state.dateTime),
                          IconButton(
                            alignment: Alignment.centerRight,
                            icon: Icon(Icons.calendar_month_sharp),
                            onPressed: () {
                              _showPicker(context).then((value) {
                                BlocProvider.of<CreateTaskBloc>(context).add(
                                    SelectedDateTimeEvent(
                                        dateTime: selectedDateTime,
                                        timeOfDay: selectedTime,
                                        selectedtag: state.selectedtag));
                              });
                            },
                          ),
                        ],
                      )),
                  
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: DropdownButton<String>(
                            value: state.selectedtag,
                            items: dropdownMenuItems
                                .map((element) => DropdownMenuItem<String>(
                                    value: element, child: Text(element)))
                                .toList(),
                            onChanged: (element) {
                              BlocProvider.of<CreateTaskBloc>(context).add(
                                  SelectedTagEvent(
                                      dateTime: state.dateTime,
                                      timeOfDay: state.dateTime,
                                      selectedtag: element!));

//selectedItem=value;
                            }),
                      ),
                    
                  
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 10, 20),
                    child: ElevatedButton(
                        child: Text("Добавить задачу"),
                        onPressed: () {
                          //Navigator.pushNamed(context,"/SignUp");
                          //logging();
                        }),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: ElevatedButton(
                        child: Text("Добавить уведомление"),
                        onPressed: () {
                          //Navigator.pushNamed(context,"/SignUp");
                          //logging();
                        }),
                  )
                ],
              ));
        }));
  }
}
