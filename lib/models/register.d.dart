class Register {
  int? id;
  String? username;
  String? password;
  String? password_salt;
  String? password_hash;
  int? roleId;

  Register({
    this.id,
    this.username,
    this.password,
    this.password_salt,
    this.password_hash,
    this.roleId,
  });
}
