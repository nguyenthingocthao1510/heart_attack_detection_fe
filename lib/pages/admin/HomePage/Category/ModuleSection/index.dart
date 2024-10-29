import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/models/module.d.dart';
import 'package:heart_attack_detection_fe/routes/route.constant.dart';
import 'package:heart_attack_detection_fe/services/moduleApi.dart';

class ModuleSection extends StatefulWidget {
  const ModuleSection({super.key});

  @override
  State<ModuleSection> createState() => _ModuleSectionState();
}

class _ModuleSectionState extends State<ModuleSection> {
  List<Module> modules = [];

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToIndex(int index) {
    _scrollController.animateTo(
      index * 220.0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 250,
      child: Card(
        color: Colors.white,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                int currentIndex = (_scrollController.offset / 220).floor();
                if (currentIndex > 0) {
                  _scrollToIndex(currentIndex - 1);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Cannot go back further')),
                  );
                }
              },
            ),
            Expanded(
              child: GestureDetector(
                onPanUpdate: (details) {
                  _scrollController.position.moveTo(
                    _scrollController.position.pixels - details.delta.dx,
                  );
                },
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: modules.length,
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final module = modules[index];
                    final name = module.name;
                    final image = module.image;
                    final route = module.route;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: SizedBox(
                        height: 200,
                        width: 200,
                        child: GestureDetector(
                          onTap: () {
                            if (route == null) {
                              Navigator.pushNamed(context, notFoundRoute);
                            } else {
                              Navigator.pushNamed(context, route!);
                            }
                          },
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                side: BorderSide(
                                  color: Colors.blue,
                                  width: 2.0,
                                )),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding:
                                      EdgeInsets.only(left: 15.0, right: 15.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                    color: Colors.grey,
                                    width: 1.0,
                                  )),
                                  child: Image.network(image!,
                                      width: 80, height: 150),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  name!,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {
                int currentIndex = (_scrollController.offset / 220).floor();
                if (currentIndex < modules.length - 1) {
                  _scrollToIndex(currentIndex + 1);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Can't move forward")),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchData() async {
    await fetchAllModule();
  }

  Future<void> fetchAllModule() async {
    final response = await ModuleAPI.fetchAllModule();
    setState(() {
      modules = response;
    });
  }
}
