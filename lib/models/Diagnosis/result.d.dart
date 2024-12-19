class DiagnosisResult {
  final int prediction;
  final int thalachh;
  final int restecg;
  final String diagnosisTime;

  DiagnosisResult({
    required this.prediction,
    required this.thalachh,
    required this.restecg,
    required this.diagnosisTime
});

  factory DiagnosisResult.fromMap(Map<String,dynamic> e) {
    return DiagnosisResult(
      prediction: e['prediction'],
      thalachh: e['thalachh'],
      restecg: e['restecg'],
      diagnosisTime: e['timestamp']
    );
  }
}