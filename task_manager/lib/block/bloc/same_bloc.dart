import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class SameBloc extends Bloc<SameBloc_Event,SameBloc_State>{
  
  SameBloc(SameBloc_State sameBloc_State):super(SameBloc_State(color: Colors.red, text: "Hello")){
    
    on((SameBloc_Event_ToColor event, Emitter<SameBloc_State> emit) => {
      emit(SameBloc_State(color: Colors.blue, text: event.text))
    });


    on((SameBloc_Event_ToRGB event, Emitter<SameBloc_State> emit) => {
      emit(SameBloc_State(color: Color.fromARGB(255, event.r, event.g, event.b), text: event.text))
    });

  }
  
 

}

abstract class SameBloc_Event{
 
}

class SameBloc_Event_ToRGB extends SameBloc_Event{
 int r ;
 int g ;
 int b ; 
  String text;
  SameBloc_Event_ToRGB({required this.r,required this.g,required this.b, required this.text});
}

class SameBloc_Event_ToColor extends SameBloc_Event{
 Color color;
 String ? text;
 SameBloc_Event_ToColor({required this.color, this.text});
}
class SameBloc_State{
   Color color;
   String? text;
  SameBloc_State({
    required this.color,
    this.text
  });
}





