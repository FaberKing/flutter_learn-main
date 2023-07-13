import 'package:flutter/material.dart';
import 'package:flutter_provider/provider/done_module_provider.dart';
import 'package:provider/provider.dart';

class DoneModuleList extends StatelessWidget {
  const DoneModuleList({super.key});

  @override
  Widget build(BuildContext context) {
    final doneModuleList =
        Provider.of<DoneModuleProvider>(context, listen: false).doneModuleList;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Done Module List'),
      ),
      body: ListView.builder(
        itemCount: doneModuleList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              doneModuleList[index],
            ),
          );
        },
      ),
    );
  }
}
