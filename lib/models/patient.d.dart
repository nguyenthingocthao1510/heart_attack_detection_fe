class Patient {
  final int id;
  final int account_id;
  final String name;
  final String gender;
  final String dob;
  final int age;
  String need_prediction;
  final String phone_number;
  final String email;
  final String address;

  Patient({
    required this.id, 
    required this.account_id, 
    required this.name,
    required this.gender,
    required this.dob,
    required this.age,
    required this.need_prediction,
    required this.phone_number,
    required this.email,
    required this.address
  });

  factory Patient.fromMap(Map<String, dynamic> e) {
    return Patient(
      id: e['id'],
      account_id: e['account_id'],
      name: e['name'],
      gender: e['gender'],
      dob: e['dob'],
      age: e['age'],
      need_prediction: e['need_prediction'],
      phone_number: e['phone_number'],
      email: e['email'],
      address: e['address']
    );
  }
}
