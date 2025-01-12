import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/assets/components/SearchButton/index.dart';
import 'package:heart_attack_detection_fe/models/module.d.dart';
import 'package:heart_attack_detection_fe/pages/admin/HomePage/index.dart';
import 'package:heart_attack_detection_fe/pages/category/Module/ModuleModal/index.dart';
import 'package:heart_attack_detection_fe/services/moduleApi.dart';

class ModulePage extends StatefulWidget {
  const ModulePage({super.key});

  @override
  State<ModulePage> createState() => _ModulePageState();
}

class _ModulePageState extends State<ModulePage> {
  List<Module> modules = [];
  String name = "";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await getAllModule();
  }

  Future<void> getAllModule() async {
    ModuleAPI moduleAPI = ModuleAPI();
    final response = await moduleAPI.filterModule(name);
    setState(() {
      modules = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text('Module'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined, color: Colors.black),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (Route<dynamic> route) => false,
            );
          },
        ),
      ),
      body: Container(
        color: Color(0xFFF5F6FA),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SearchFunction(onSearch: (query) {
              setState(() {
                name = query;
              });
              fetchData();
            }),
            Expanded(
                child: ListView.builder(
                    itemCount: modules.length,
                    padding: EdgeInsets.only(bottom: 80),
                    itemBuilder: (context, index) {
                      final module = modules[index];
                      final name = module.name;
                      final route = module.route;

                      return Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: BorderSide(color: Colors.blue)),
                        child: ListTile(
                          title: Text(name!),
                          subtitle: Text('${route}'),
                          trailing: IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ModuleModal(module: module),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.chevron_right)),
                        ),
                      );
                    }))
          ],
        ),
      ),
      floatingActionButton: IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ModuleModal()),
          );
        },
        icon: Icon(Icons.add),
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.blue),
            iconColor: WidgetStatePropertyAll(Colors.white),
            iconSize: WidgetStatePropertyAll(35)),
      ),
    );
  }
}
