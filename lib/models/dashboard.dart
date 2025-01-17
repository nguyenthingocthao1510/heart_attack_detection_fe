import 'package:intl/intl.dart';

class Dashboard {
  int? id;
  String? device_id;
  double? thalachh;
  double? restecg;
  double? avg_bpm;
  DateTime? timestamp;

  Dashboard({
    this.id,
    this.device_id,
    this.thalachh,
    this.restecg,
    this.avg_bpm,
    this.timestamp,
  });

  factory Dashboard.fromMap(Map<String, dynamic> e) {
    return Dashboard(
      id: e['id'],
      device_id: e['device_id'],
      thalachh: (e['thalachh'] is int)
          ? (e['thalachh'] as int).toDouble()
          : e['thalachh'],
      restecg: (e['restecg'] is int)
          ? (e['restecg'] as int).toDouble()
          : e['restecg'],
      avg_bpm: (e['avg_bpm'] is int)
          ? (e['avg_bpm'] as int).toDouble()
          : e['avg_bpm'],
      timestamp: e['timestamp'] != null
          ? DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'")
              .parse(e['timestamp'], true)
          : null,
    );
  }
}
