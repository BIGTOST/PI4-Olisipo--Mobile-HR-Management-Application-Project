import 'package:adm23194/class.global.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'server.user.data.dart' as user;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// logica, em teoria:
// adiciona um novo evento, coloca a hora de inicio e fim daquele dia,
// depois escolhe o Status, Event e EventType através de dropdowns (pode ser mudado),
// por fim adiciona tudo ao evento com o createEvent.

FlutterSecureStorage storage = const FlutterSecureStorage();

//obtain user's name to later display it
Future<int?> createEvent(String start, String end, String status, String event,
    int idEventType) async {
  var url = Uri.parse(
    Vars.apiRoute + '/calendar/create',
  );

  var response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      "start": start,
      "end": end,
      "vis": 1,
      "idUser": user.fetchUserID(),
      "status": status,
      "event": event,
      "idEventType": idEventType,
      "idDoc": null
    }),
  );

  if (response.statusCode == 200) {}
}

Future<List<dynamic>> fetchEventStatus() async {
  String? storedToken = await storage.read(key: 'token');
  var url = Uri.parse(
    Vars.apiRoute + '/calendarStatus/',
  );
  var response = await http.get(url, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'authorization': 'Bearer $storedToken',
  });

  if (response.statusCode == 200) {
    var data = json.decode(response.body);

    List<dynamic> dataList = List<String>.from(data['status']);
    print(data);
    print(dataList);
    return dataList;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List<String>> fetchMainEvent() async {
  var url = Uri.parse(
    Vars.apiRoute + '/calendarEvent/',
  );
  var response = await http.post(url, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  });

  if (response.statusCode == 200) {
    var data = json.decode(response.body);

    List<String> dataList = List<String>.from(data['event']);

    print(data);
    print(dataList);
    return dataList;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List<String>> fetchSubEvent() async {
  var url = Uri.parse(
    Vars.apiRoute + '/calendarEventType/',
  );
  var response = await http.post(url, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  });

  if (response.statusCode == 200) {
    var data = json.decode(response.body);

    List<String> dataList = List<String>.from(data['eventType']);

    print(data);
    print(dataList);
    return dataList;
  } else {
    throw Exception('Failed to load data');
  }
}
