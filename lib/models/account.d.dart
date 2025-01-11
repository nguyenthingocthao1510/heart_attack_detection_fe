class Account {
  final int? id;
  final String? username;
  final String? account_status;

  Account({this.id, this.username, this.account_status});

  // Map username
  factory Account.fromMap(Map<String, dynamic> e) {
    return Account(
        id: e['id'],
        username: e['username'],
        account_status: e['account_status']);
  }
}
