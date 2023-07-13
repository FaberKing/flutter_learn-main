import 'package:flutter/material.dart';

class ModuleList extends StatefulWidget {
  final List<String> doneModuleList;
  const ModuleList({super.key, required this.doneModuleList});

  @override
  State<ModuleList> createState() => _ModuleListState();
}

class _ModuleListState extends State<ModuleList> {
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
        return ModuleTile(
          moduleName: _moduleList[index], //Drilling
          isDone: widget.doneModuleList.contains(
            _moduleList[index],
          ),
          onClick: () {
            setState(() {
              widget.doneModuleList.add(
                _moduleList[index],
              );
            });
          },
          onClick2: () {
            setState(() {
              widget.doneModuleList.remove(
                _moduleList[index],
              );
            });
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
