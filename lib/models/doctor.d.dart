class Doctor {
  int? account_id;
  String? address;
  int? age;
  String? dob;
  String? email;
  int? gender;
  int? id;
  String? name;
  String? specialization;

  Doctor(
      {this.account_id,
      this.address,
      this.age,
      this.dob,
      this.email,
      this.gender,
      this.id,
      this.name,
      this.specialization});

  factory Doctor.fromMap(Map<String, dynamic> e) {
    return Doctor(
      account_id: e['account_id'],
      address: e['address'],
      age: e['age'],
      dob: e['dob'],
      email: e['email'],
      gender: e['gender'],
      id: e['id'],
      name: e['name'],
      specialization: e['specialization'],
    );
  }
// int? account_id;
// int? id;
// String? name;
//
// Doctor({this.id, this.account_id, this.name});
//
// factory Doctor.fromMap(Map<String, dynamic> e) {
//   return Doctor(
//     account_id: e['account_id'],
//     id: e['id'],
//     name: e['name'],
//   );
// }
}
