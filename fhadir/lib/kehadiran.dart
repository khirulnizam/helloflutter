
class Kehadiran {
  final String id;
  final String gpsdata;
  final String statusbekerja;

  //this.website,
  //website: json['website'] as String,

  Kehadiran({this.id, this.gpsdata, this.statusbekerja});

  factory Kehadiran.fromJson(Map<String, dynamic> json) {
    return Kehadiran(
      id: json['id'] as String,
      gpsdata: json['gpsdata'] as String,
      statusbekerja: json['statusbekerja'] as String,
    );
  }
}