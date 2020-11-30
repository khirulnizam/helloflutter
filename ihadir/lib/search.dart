import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'kehadiran.dart';
import 'listrekodkehadiran.dart';
import 'datapegawai.dart';

Future<List<Kehadiran>> fetchTrainings(http.Client client) async {
  //fetch JSON data from server
  final response = await client.get('http://kehadiran.medac.gov.my/iHadirTraining/listingflutter.php');
  //
  return compute(parseTrainings, response.body);//capture data body
}

List<Kehadiran> parseTrainings(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  //return data in linked list
  return parsed.map<Kehadiran>((json) => Kehadiran.fromJson(json)).toList();
}

class Search extends StatelessWidget {
  final String title;
  final DataPegawai data;

  Search({Key key, this.title,this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Senarai Kehadiran'),
      ),

      body: FutureBuilder<List<Kehadiran>>(
        future: fetchTrainings(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? ListViewKehadiran(kehadirans: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}