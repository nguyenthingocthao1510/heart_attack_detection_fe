class Dashboard {
  double? AvgBPM;
  double? BPM;
  double? ECG;
  double? IR;
  String? timestamp;

  Dashboard({this.AvgBPM, this.BPM, this.ECG, this.IR, this.timestamp});

  factory Dashboard.fromMap(Map<String, dynamic> e) {
    return Dashboard(
      AvgBPM: e['AvgBPM'],
      BPM: e['BPM'],
      ECG: e['ECG'],
      IR: e['IR'],
      timestamp: e['timestamp'],
    );
  }
}
