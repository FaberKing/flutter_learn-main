import 'dart:io';
import 'package:path/path.dart' as p;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FileDialog extends StatelessWidget {
  final List<FileSystemEntity> files;
  const FileDialog({Key? key, required this.files}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Choose your file'),
      ),
      child: ListView.builder(
        itemBuilder: (context, index) {
          final file = files[index];
          return Material(
            child: ListTile(
              title: Text(p.split(file.path).last),
              onTap: () {
                Navigator.pop(context, file);
              },
            ),
          );
        },
        itemCount: files.length,
      ),
    );
  }
}
