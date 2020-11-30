class Kehadiran {
  final String id;
  final String pegawai_id;
  final String date_report;
  final String status_report;
  final String lokasi;
  //kehadiran.dart
  //this.website,
  //website: json['website'] as String,

  Kehadiran({this.id, this.pegawai_id, this.date_report,
    this.lokasi, this.status_report});

  factory Kehadiran.fromJson(Map<String, dynamic> json) {
    return Kehadiran(
      id: json['id'] as String,
      lokasi: json['lokasi'] as String,
      status_report: json['status_report'] as String,
      date_report: json['date_report'] as String,
      pegawai_id: json['pegawai_id'] as String,
    );
  }
}