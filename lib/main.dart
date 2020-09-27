import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: swipper(),
    );

  }
}



class swipper extends StatefulWidget {



   @override
  _swipperState createState() => _swipperState();
}

class _swipperState extends State<swipper> {
  List<memeModal> _notes =List<memeModal>();

  Future<List<memeModal>> fetchImage() async {
   var url ="https://meme-api.herokuapp.com/gimme/2";
    var response = await http.get(url);
    var notes =List<memeModal>();

    if(response.statusCode==200){
      var notesJson =json.decode(response.body);
      for (var noteJson in notesJson){
        notes.add(memeModal.fromJson(noteJson));
      }
      return notes;
    }
  }
  @override
  void initState(){
    fetchImage().then((value){
      setState((){

    _notes.addAll(value);


    }) ;


    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Meme App')
        ,

      ),
      body:Center(
        child: Container(
          height: MediaQuery.of(context).size.height*.9,
          child: TinderSwapCard(
            orientation: AmassOrientation.TOP,
            totalNum: _notes.length,
            stackNum: 3,
            maxHeight: MediaQuery.of(context).size.height*.9,
            minHeight: MediaQuery.of(context).size.height*.8,
            maxWidth: MediaQuery.of(context).size.width*.9,
            minWidth: MediaQuery.of(context).size.width*.8,
            
            cardBuilder: (context,index)=>Card(
           child: Image.network('${_notes[index]}'),

            ),
          ),
        ),
      ) ,
    );
  }
}
