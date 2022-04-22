import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:band_names/models/band.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Band> bands = [
    Band(id: '1', name: 'Green Day', votes: 20),
    Band(id: '2', name: 'Enjambre', votes: 10),
    Band(id: '3', name: 'Arctic Monkeys', votes: 15),
    Band(id: '4', name: 'System Of A Down', votes: 50)
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BandNames', style: TextStyle(color:Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, i) => _bandTile(bands[i])
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: addNewBand,
        backgroundColor: Colors.red,
      ),
   );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        print('direction: $direction');
        print('direction: ${band.id}');
      },
      background: Container(
        padding: EdgeInsets.only(left: 8.0),
        color: Colors.red[200],
        child: Align(
          alignment: Alignment.centerLeft,
          child: Icon(Icons.delete_outline_outlined, color: Colors.white),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
        child: Text(band.name.substring(0,2), style: TextStyle(color: Colors.red),),
        backgroundColor: Colors.red[100],                
        ),
        title: Text(band.name),
        trailing: Text('${band.votes}', style: TextStyle(fontSize: 20),),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }

  addNewBand(){

    final textController = new TextEditingController();

    if(Platform.isAndroid){
      
    }

    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text('New Band Name'),
        content: TextField(
          controller: textController,
        ),
        actions: <Widget>[
          MaterialButton(
            child: Text('Add'),
            elevation: 5,
            textColor: Colors.red,
            onPressed: () => addBandToList(textController.text))
        ]
      );

    }); 
    /*showCupertinoDialog(context: context, builder: ( _ ){
      return CupertinoAlertDialog(
        title: Text('New Band Name'),
        content: TextField(
            controller: textController,
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('Add'),
              onPressed: () => addBandToList(textController.text)),
              CupertinoDialogAction(
              isDestructiveAction: true,
              child: Text('Dismiss'),
              onPressed: () => Navigator.pop(context))
          ]
      );
    });*/
  }

  void addBandToList(String name) {
    print(name);
    if (name.length > 1){
      this.bands.add(new Band(id: DateTime.now().toString(), name: name, votes: 0));
      setState(() {});
    }

    Navigator.pop(context);
  }
}