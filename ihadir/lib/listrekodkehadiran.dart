import 'package:flutter/material.dart';
import 'kehadiran.dart';
//code sample from http://fstm.kuis.edu.my/blog/flutter-json/

class ListViewKehadiran extends StatelessWidget {
  final List<Kehadiran> kehadirans;

  ListViewKehadiran({Key key, this.kehadirans}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: kehadirans.length,
          padding: const EdgeInsets.all(15.0),
          itemBuilder: (context, position) {
            return Column(
              children: <Widget>[
                Divider(height: 20.0),
                ListTile(
                  title: Text(
                    '${kehadirans[position].lokasi}',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.deepOrangeAccent,
                    ),
                  ),
                  subtitle: Text(
                    '${kehadirans[position].date_report}',
                    style: new TextStyle(
                      fontSize: 18.0,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  leading: Column(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        radius: 25.0,
                        child: Text(
                          '${kehadirans[position].pegawai_id}',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),

                ),
              ],
            );
          }),
    );
  }

  void _onTapItem(BuildContext context, Kehadiran kehadiran) {
    Scaffold
        .of(context)
        .showSnackBar(
        new SnackBar(content: new Text(kehadiran.id + ' - ' + kehadiran.lokasi))
    );
  }
}