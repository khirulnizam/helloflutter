import 'package:flutter/material.dart';
import 'data.dart';
//filename formupdate.dart

class FormUpdate extends StatelessWidget{
  final Data data;

  FormUpdate({@required this.data});
  TextEditingController _number= new TextEditingController();
  TextEditingController _name= new TextEditingController();

  Widget build(BuildContext context){
    return Scaffold(
      appBar: new AppBar (title: new Text('Form Update')),
      body: ListView(
        padding: EdgeInsets.all(15.0),
        children:<Widget>[
          Image(image: AssetImage('assets/kuislogo.png')),
          Divider(),//jarak widget
          TextFormField(
            initialValue: this.data.name,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Nama"
            ),
          ),
          Divider(),//jarak widget

          TextFormField(
            initialValue: this.data.number.toString(),
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Nombor pilihan"
            ),
          ),
          Divider(),//jarak widget

          RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: const Text('Pop data'),
              onPressed: (){}
              ),


        ]
      ),
    );
  }

}