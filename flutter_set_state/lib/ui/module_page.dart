import 'package:flutter/material.dart';
import 'package:flutter_set_state/ui/done_module_list.dart';
import 'package:flutter_set_state/ui/module_list_page.dart';

class ModulePage extends StatefulWidget {
  const ModulePage({super.key});

  @override
  State<ModulePage> createState() => _ModulePageState();
}

class _ModulePageState extends State<ModulePage> {
  final List<String> doneModuleList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memulai Pemograman Dengan Dart'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DoneModuleList(
                    doneModuleList: doneModuleList,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      body: ModuleList(
        doneModuleList: doneModuleList,
      ),
    );
  }
}
