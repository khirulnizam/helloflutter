//class FormPage
import 'package:flutter/material.dart';
//import 'package:toast/toast.dart';

class FormPage extends StatelessWidget {

  TextEditingController _name = TextEditingController();

  //@override
  Widget build(BuildContext context){
    //our code
    return Scaffold(
      appBar: new AppBar(title: new Text('Form '
          'Page'),),
      body: ListView(
          padding: EdgeInsets.all(12.0),
          children: <Widget>[
              Padding(//TextField ID
                padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 15.0),
                child: TextField(
                  controller: _name,
                  decoration: InputDecoration(hintText: 'number field'),
                ),
              ),
          ],
      ),
    );
  }//end Widgets
}//end FormPage