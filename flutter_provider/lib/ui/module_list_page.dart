import 'package:flutter/material.dart';
import 'package:flutter_provider/provider/done_module_provider.dart';
import 'package:provider/provider.dart';

class ModuleList extends StatelessWidget {
  const ModuleList({super.key});

  final List<String> _moduleList = const [
    'Modul 1 - Pengenalan Dart',
    'Modul 2 - Program Dart Pertamamu',
    'Modul 3 - Dart Fundamental',
    'Modul 4 - Control Flow',
    'Modul 5 - Collections',
    'Modul 6 - Object Oriented Programming',
    'Modul 7 - Functional Styles',
    'Modul 8 - Dart Type System',
    'Modul 9 - Dart Futures',
    'Modul 10 - Effective Dart',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _moduleList.length,
      itemBuilder: (context, index) {
        return Consumer<DoneModuleProvider>(
          builder: (context, DoneModuleProvider value, child) {
            return ModuleTile(
              moduleName: _moduleList[index],
              isDone: value.doneModuleList.contains(
                _moduleList[index],
              ),
              onClick: () {
                value.complete(
                  _moduleList[index],
                );
              },
              onClick2: () {
                value.reverse(
                  _moduleList[index],
                );
              },
            );
          },
        );
      },
    );
  }
}

class ModuleTile extends StatelessWidget {
  final String moduleName;
  final bool isDone;
  final Function() onClick;
  final Function() onClick2;
  const ModuleTile({
    super.key,
    required this.moduleName,
    required this.isDone,
    required this.onClick,
    required this.onClick2,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(moduleName),
      trailing: isDone
          ? IconButton(
              onPressed: onClick2,
              icon: const Icon(Icons.done),
            )
          // const Icon(Icons.done)
          : ElevatedButton(
              onPressed: onClick,
              child: const Text('Done'),
            ),
    );
  }
}
