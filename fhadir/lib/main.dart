import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'listing.dart';

void main() => runApp(MyApp());

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
        // Define the default Brightness and Colors
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyanAccent,

        // Define the default Font Family
        fontFamily: 'Montserrat',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: MyHomePage(title: 'Apps Kehadiran Medac'),
      routes: <String, WidgetBuilder>{
        '/listing' : (BuildContext context) => new Listing(),

      },
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

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String dropdownValue, papardata, gpsdata,statusbekerja, statusdata;
  TextEditingController _lokasi=new TextEditingController();
  String lokasigps;
  // geolocator: ^5.1.3 example from 
  // https://www.digitalocean.com/community/tutorials/flutter-geolocator-plugin
  Geolocator _geolocator;//geolocation
  Position _currentPosition;

    //check permission
    //Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    @override
    void initState() {
      super.initState();

      _geolocator = Geolocator();
      _getCurrentLocation();
    }
    _getCurrentLocation() {
      final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

      geolocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
          .then((Position position) {
        setState(() {
          _currentPosition = position;
          lokasigps='LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}';
        });
      }).catchError((e) {
        print(e);
      });
    }//geolocator

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


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(

          //mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image(image: AssetImage('assets/fhadirbanner.png')),
            Padding(//TextField name
              padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 15.0),
              child: Text(
                "Lokasi GPS LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}"
                
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: DropdownButton<String>(
                value: dropdownValue,
                isExpanded: true,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.white),
                underline: Container(
                  height: 2,
                  color: Colors.white,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
                items: <String>['Hadir pejabat', 'Bekerja dari rumah', 
                'Kuarantine', 'Kompleks']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: RaisedButton(
              child: Text('Rekodkan kehadiran saya'),
              color: Colors.green,
              onPressed: (){
                gpsdata='LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}';
                statusbekerja=dropdownValue;
                papardata=gpsdata+' '+statusbekerja;
                //var datauser = json.decode(response.body);
                simpanhadir(gpsdata,statusbekerja);
                //Toast.show(statusdata, context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                //senddata();

              },
            ),
          ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {Navigator.of(context).pushNamed('/listing'); },
        tooltip: 'Senarai',
        child: Icon(Icons.list),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<List> senddata() async {
  // code sample from
  // https://medium.com/@dev_raushanjha/sendhow-to-send-data-from-flutter-app-to-mysql-database-8e79844fc234
    var url="http://khirulnizam.com/training/flutterinsert.php";
    var data={"gpsdata": gpsdata, "statusbekerja": statusbekerja};
    var response = await http.post(url, body: json.encode(data));
    var message = json.decode(response.body);
 
    // If Web call Success than Hide the CircularProgressIndicator.
    if(response.statusCode == 200){

       Toast.show(message, context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
    }
  }//sendata

  // Method to add employee to the database...
  Future<String> simpanhadir(String gpsdata, String statusbekerja) async {
    try {
      var map = Map<String, dynamic>();
      map['gpsdata'] = gpsdata;
      map['statusbekerja'] = statusbekerja;
      final response = await http.post("http://khirulnizam.com/training/insertflutter.php", body: map);
      print('simpanhadir Response: ${response.body}');
      if (200 == response.statusCode) {
        Toast.show(response.body, context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }
}
