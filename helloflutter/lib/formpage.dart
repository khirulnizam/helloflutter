//class FormPage
import 'package:flutter/material.dart';
import 'data.dart';//import data stuct
//import 'package:toast/toast.dart';

class FormPage extends StatelessWidget {
  final Data data;
  // In the constructor, require a Data.
  FormPage({@required this.data});
  //num

  //TextEditingController _number = TextEditingController();
  //TextEditingController _name = TextEditingController();


  //@override
  Widget build(BuildContext context){
    //our code
    return Scaffold(
      appBar: new AppBar(title: new Text('Form '
          'Page'),),
          
      body: ListView(  //ListView container example
          padding: EdgeInsets.all(12.0),
          children: <Widget>[
              Padding(//TextField ID
              padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 15.0),
                child: Image(image: AssetImage('assets/lanskap.png')),
              ),
              Padding(//TextField ID
                padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 15.0),
                child: TextFormField(
                  //controller: _number,
                  initialValue: "Hi "+data.name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Your name',
                  ),
                ),
              ),//padding name
              Padding(//TextField ID
                padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 15.0),
                child: TextFormField(
                  //controller: _number,
                  initialValue: "Your number is "+data.number.toString(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Your number',
                  ),
                ),
              ),//number padding
              Padding(
                padding: EdgeInsets.all(16.0),
                child:RaisedButton(
                  textColor: Colors.white,
                  color: Colors.green,
                  child: const Text(
                  'Save/update',
                  style: TextStyle(fontSize: 20)
                  ),
                  onPressed: () {},
                ),
              ),
          ],

      ),
    );
  }//end Widgets
}//end FormPage