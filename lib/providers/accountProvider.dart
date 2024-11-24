import 'package:flutter/material.dart';

class AccountProvider with ChangeNotifier {
  String? _accountId;

  String? get accountId => _accountId;

  void setAccountId(String? accountId) {
    _accountId = accountId;
    notifyListeners();
  }
}
