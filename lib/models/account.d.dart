class Account {
  final int? id;
  final String? username;

  Account({
    this.id,
    this.username,
  });

  // Map username
  factory Account.fromMap(Map<String, dynamic> e) {
    return Account(
      id: e['id'],
      username: e['username'],
    );
  }
}
