class Dashboard {
  int? heartRate;
  String? timestamp;
  int? userId;
  int? temperature;

  Dashboard({this.heartRate, this.timestamp, this.userId, this.temperature});

  factory Dashboard.fromMap(Map<String, dynamic> e) {
    return Dashboard(
      heartRate: e['heartRate'],
      timestamp: e['timestamp'],
      userId: e['userId'],
      temperature: e['temperature'],
    );
  }
}
