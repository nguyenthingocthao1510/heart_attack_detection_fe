class Diagnosis {
  final int age;
  final int trtbps;
  final int chol;
  final int thalachh;
  double oldpeak;
  final String sex;
  final String exng;
  final int caa;
  final String cp;
  final int fbs;
  final int restecg;
  final String slp;
  final String thall;

  Diagnosis({
    required this.age,
    required this.trtbps,
    required this.chol,
    required this.thalachh,
    required this.oldpeak,
    required this.sex,
    required this.exng,
    required this.caa,
    required this.cp,
    required this.fbs,
    required this.restecg,
    required this.slp,
    required this.thall,
  });

    Map<String, dynamic> toJson() {
    return {
      'age': age,
      'trtbps': trtbps,
      'chol': chol,
      'thalachh': thalachh,
      'oldpeak': oldpeak,
      'sex': sex,
      'exng': exng,
      'caa': caa,
      'cp': cp,
      'fbs': fbs,
      'restecg': restecg,
      'slp': slp,
      'thall': thall,
    };
  }
}