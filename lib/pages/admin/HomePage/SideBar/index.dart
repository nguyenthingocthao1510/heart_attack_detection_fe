import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/models/moduleAuthorization.d.dart';
import 'package:heart_attack_detection_fe/providers/roleProvider.dart';
import 'package:heart_attack_detection_fe/routes/route.constant.dart';
import 'package:heart_attack_detection_fe/services/moduleAuthorization.dart';
import 'package:provider/provider.dart';

class SideBar extends StatefulWidget {
  final bool isSidebarOpen;
  final VoidCallback onToggle;

  const SideBar({
    super.key,
    required this.isSidebarOpen,
    required this.onToggle,
  });

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder<List<ModuleRole>>(
            future: getAllModuleInRole(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error loading modules'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No modules found'));
              }

              final modules = snapshot.data!;
              return ListView.builder(
                itemCount: modules.length,
                itemBuilder: (context, index) {
                  final module = modules[index];
                  final name = module.name ?? 'Unnamed Module';
                  final route = module.route;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: widget.isSidebarOpen
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.center,
                      children: [
                        if (widget.isSidebarOpen)
                          const Expanded(
                            child: Center(
                              child: Icon(Icons.grid_view),
                            ),
                          )
                        else
                          const Center(
                            child: Icon(Icons.grid_view),
                          ),
                        if (widget.isSidebarOpen) const SizedBox(width: 8.0),
                        if (widget.isSidebarOpen)
                          Expanded(
                            flex: 3,
                            child: Text(
                              name,
                              style: const TextStyle(fontSize: 16.0),
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: IconButton(
              icon: Icon(
                widget.isSidebarOpen
                    ? Icons.keyboard_double_arrow_right
                    : Icons.keyboard_double_arrow_left,
                color: Colors.black,
              ),
              onPressed: widget.onToggle,
              style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all<Color>(Colors.grey[100]!),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<List<ModuleRole>> getAllModuleInRole() async {
    if (!mounted) return [];
    try {
      final roleId =
          int.parse(Provider.of<RoleProvider>(context, listen: false).roleId!);
      return await ModuleRoleAPI.getAllModuleInRole(roleId);
    } catch (error) {
      return [];
    }
  }
}
