import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:band_names/models/band_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Metalica', votes: 5),
    Band(id: '2', name: 'Coldplay', votes: 3),
    Band(id: '3', name: 'Damas Gratis', votes: 4),
    Band(id: '4', name: 'Ed Sheeran', votes: 2),
    Band(id: '5', name: 'Daft Punk', votes: 5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nombres de Bandas', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) => _bandTile(bands[index]),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        elevation: 1,
        onPressed: addNewBand,
      ),
    );
  }

  Widget _bandTile(Band band) {
    final Size size = MediaQuery.of(context).size;
    return Dismissible(
      key: Key(band.id!),
      direction: DismissDirection.startToEnd,
      onDismissed: (DismissDirection direction) {
        print('direccion : $direction');
        // TODO: Llamar el borrado al server
      },
      background: Container(
        padding: const EdgeInsets.only(left: 8),
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Eliminar Banda',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name!.substring(0, 2)),
          backgroundColor: Colors.blue.shade100,
        ),
        title: Text(band.name!),
        trailing: Text(
          '${band.votes}',
          style: TextStyle(fontSize: size.width * 0.05),
        ),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }

  addNewBand() {
    final textController = TextEditingController();

    if (!Platform.isAndroid) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Nueva Banda'),
            content: TextField(
              controller: textController,
            ),
            actions: [
              MaterialButton(
                child: const Text('Agregar'),
                elevation: 5,
                textColor: Colors.blue,
                onPressed: () => addBandToList(textController.text),
              )
            ],
          );
        },
      );
    }

    showCupertinoDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: const Text('Nueva Banda'),
          content: CupertinoTextField(
            controller: textController,
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text('Agregar'),
              isDefaultAction: true,
              onPressed: () => addBandToList(textController.text),
            ),
            CupertinoDialogAction(
              child: const Text('Cerrar'),
              isDestructiveAction: true,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  void addBandToList(String name) {
    if (name.length > 1) {
      bands.add(
        Band(
          id: DateTime.now().toString(),
          name: name,
          votes: 0,
        ),
      );

      setState(() {});
    }
    Navigator.pop(context);
  }
}
