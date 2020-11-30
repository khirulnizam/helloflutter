import 'dart:convert';

//server Url
// https://kehadiran.medac.gov.my/iHadirTraining/insertflutter.php

import 'package:flutter/material.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'search.dart';
import 'datapegawai.dart';

void main() {
  runApp(MyApp());
}

DataPegawai datapegawai;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'iHadir madec'),
      routes:<String, WidgetBuilder>{
        '/search': (BuildContext context)=> new Search(data:datapegawai),
      }
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

double longitude, latitude;
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Position _currentPosition;
  Geolocator _geolocator;

  @override
  void initState(){
    super.initState();

    _geolocator=Geolocator();
    _getCurrentLocation();//panggil function
  }//end initState

  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        //capture long/lat value
        latitude=_currentPosition.latitude;
        longitude=_currentPosition.longitude;
      });
    }).catchError((e) {
      print(e);
    });
  }//end getCurrentLocation

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }
  //declare input name
  TextEditingController lokasi=TextEditingController();
  TextEditingController pegawai_id=TextEditingController();
  int _optionval=1;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: ListView(

          //mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image(image : AssetImage('assets/logo_medac.png')),
            //Spacer(),
            Text(
              'Apps ini merekod kehadiran',
            ),
            Text(
              'Lokasi GPS: Longitude $longitude : Latitude $latitude'
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 15.0),
              child: TextField(
                controller: pegawai_id,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'ID Pegawai'
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 15.0),
              child: DropdownButton(
                value: _optionval,
                items: [
                  DropdownMenuItem(
                    child:Text('Hadir bertugas'),
                    value:1,
                  ),
                  DropdownMenuItem(
                      child:Text('Bekerja dari rumah'),
                      value:2,
                  ),
                ],//end items
                  isExpanded:true,//full block

                  onChanged: (value) {
                    setState(() {
                      _optionval = value;
                    }); // end onChange
                  })
              ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 15.0),
            child:RaisedButton(
              onPressed:(){
                String ayatmesej="Lokasi "+ lokasi.text+
                    " Status "+ _optionval.toString();
                String gpsdata="Latitude $latitude : Longitude $longitude";

                //simpan rekod
                simpanhadir(gpsdata, _optionval.toString(), pegawai_id.text);////dummy

                //navigate to search.dart


              },//en onPressed
              child: Text('Hantar'),
              color:Colors.green,
            ),
          ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 15.0),
          child:RaisedButton(
            onPressed:(){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context)=>Search(),
                    )
                );
              },
              child:Text('Carian kehadiran pegawai'),
            color:Colors.amber,
            ),
          ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          //invode page search
          Navigator.of(context).pushNamed('/search');
        },
        tooltip: 'Carian',
        child: Icon(Icons.search),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<String> simpanhadir(String gpsdata, String statusbekerja,
      String pegawai_id) async {
    try {
      var map = Map<String, dynamic>();
      map['gpsdata'] = gpsdata;
      map['statusbekerja'] = statusbekerja;
      map['pegawai_id'] = pegawai_id;
      final response = await http.post("https://kehadiran.medac.gov.my/iHadirTraining/insertflutter.php", body: map);
      print('simpanhadir Response: ${response.body}');
      if (200 == response.statusCode) {
        Toast.show(response.body, context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
        return response.body;
      } else {
        Toast.show(response.body, context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }//end simpanhadir
}

