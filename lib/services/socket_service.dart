import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

enum ServerStatus { online, offline, connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.connecting;
  late IO.Socket _socket;

  ServerStatus get serverStatus => this._serverStatus;
  IO.Socket get socket => this._socket;

  SocketService() {
    this._initConfig();
  }

  void _initConfig() {
    // Dart client
    this._socket = IO.io(
        'http://192.168.0.9:3000',
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .enableAutoConnect()
            .build());
    this._socket.onConnect((_) {
      print('Conectado');
      this._serverStatus = ServerStatus.online;
      notifyListeners();
    });
    this._socket.onDisconnect((_) {
      print('Desconectado');
      this._serverStatus = ServerStatus.offline;
      notifyListeners();
    });

    // socket.on('emitir-mensaje', (payload) {
    //   print('nuevo-mensaje:');
    //   print('NOMBRE: ' + payload['nombre']);
    //   print('MENSAJE: ' + payload['mensaje']);
    //   print(payload.containsKey('mensaje2') ? payload['mensaje2'] : 'no hay');
    // });
  }
}
