import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/assets/components/SearchButton/index.dart';
import 'package:heart_attack_detection_fe/models/account.d.dart';
import 'package:heart_attack_detection_fe/services/accountApi.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  List<Account> accounts = [];
  String username = "";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await getAllAccount();
  }

  Future<void> getAllAccount() async {
    AccountAPI accountAPI = AccountAPI();
    final response = await accountAPI.filterAccount(username);
    setState(() {
      accounts = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text('Account'),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back_outlined, color: Colors.black),
        // onPressed: () {
        //   Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => HomePage(),
        //     ),
        //     (Route<dynamic> route) => false,
        //   );
        // },
        // ),
      ),
      body: Container(
        color: Color(0xFFF5F6FA),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SearchFunction(onSearch: (query) {
              setState(() {
                username = query;
              });
              fetchData();
            }),
            Expanded(
                child: ListView.builder(
                    itemCount: accounts.length,
                    padding: EdgeInsets.only(bottom: 80),
                    itemBuilder: (context, index) {
                      final account = accounts[index];
                      final name = account.username;
                      final status = account.account_status;

                      return Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: BorderSide(color: Colors.blue)),
                        child: ListTile(
                          title: Text('Username: ${name!}'),
                          subtitle: Text('Status: ${status}'),
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
