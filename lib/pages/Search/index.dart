import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/assets/components/SearchButton/index.dart';
import 'package:heart_attack_detection_fe/assets/dump/Search/index.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Search> modules = [];
  String name = "";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });
    await getAllInformation();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> getAllInformation() async {
    final response = await SearchAPI.getAllInformation(name);
    setState(() {
      modules = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchFunction(onSearch: (query) {
              setState(() {
                name = query;
              });
              fetchData();
            }),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: modules.length,
                    itemBuilder: (context, index) {
                      final module = modules[index];
                      return ListTile(
                        title: Text(module.name ?? 'No name'),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
