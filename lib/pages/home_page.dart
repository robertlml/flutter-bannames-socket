import 'dart:io';

import 'package:band_name_app/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Metalica', votes: 5),
    Band(id: '2', name: 'Bon Jovi', votes: 2),
    Band(id: '3', name: 'Linkin Park', votes: 3),
    Band(id: '4', name: 'The Ramus', votes: 4),
    Band(id: '5', name: 'The Police', votes: 5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BandNames',
          style: TextStyle(color: Colors.black45),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
          itemCount: bands.length,
          itemBuilder: (context, i) => _bandTitle(bands[i])),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: addnewBand,
      ),
    );
  }

  Widget _bandTitle(Band band) {
    return Dismissible(
     
    //  movementDuration: Duration(seconds: 2),
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        print('direction: $direction');
         print('id: ${band.id}');
      },
       background: Container(
       padding: EdgeInsets.only( left: 8.0),
       color: Colors.redAccent,
       child: Align(
         alignment: Alignment.centerLeft,
         child: Text('Eliminar Banda', style: TextStyle( color: Colors.white)),
       ),),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name),
        trailing: Text(
          '${band.votes}',
          style: TextStyle(fontSize: 20),
        ),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }

  addnewBand() {
    final textController = TextEditingController();
    if (Platform.isAndroid) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('New band names'),
              content: TextField(
                controller: textController,
              ),
              actions: [
                MaterialButton(
                  child: Text('Agregar'),
                  textColor: Colors.blue,
                  elevation: 5,
                  onPressed: () => addBanTolist(textController.text),
                )
              ],
            );
          });
    } else {
      showCupertinoDialog(
          context: context,
          builder: (_) {
            return CupertinoAlertDialog(
                title: Text('New ban (name'),
                content: CupertinoTextField(
                  controller: textController,
                ),
                actions: [
                  CupertinoDialogAction(
                      isDefaultAction: true, child: Text('Agregar')),
                  CupertinoDialogAction(
                      child: Text('Dismiss'),
                      onPressed: () => Navigator.pop(context))
                ]);
          });
    }
  }

  void addBanTolist(String name) {
    print(name);
    if (name.length > 1) {
      this.bands.add(new Band(id: DateTime.now().toString(), name: name, votes: 0));

      setState(() {
          
        });

    }
    
    Navigator.pop(context);
  }
}
