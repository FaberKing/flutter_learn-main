import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

import 'package:course_asset_management/config/app_constant.dart';
import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:d_method/d_method.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateAssetPage extends StatefulWidget {
  const CreateAssetPage({super.key});

  @override
  State<CreateAssetPage> createState() => _CreateAssetPageState();
}

class _CreateAssetPageState extends State<CreateAssetPage> {
  final formKey = GlobalKey<FormState>();
  final editName = TextEditingController();
  List<String> types = [
    'Baju',
    'Transportasi',
    'Peralatan',
    'Elektronik',
    'Bangunan',
    'Furnitur',
    'Lain',
  ];
  String type = 'Baju';
  String? imageName;
  Uint8List? imageByte;

  pickImage(ImageSource source) async {
    final picked = await ImagePicker().pickImage(source: source);
    if (picked != null) {
      imageName = picked.name;
      imageByte = await picked.readAsBytes();
      setState(() {});
    }

    DMethod.printBasic('imageName : $imageName');
  }

  save() async {
    bool isValidInput = formKey.currentState!.validate();
    // if not valid stop/return
    if (!isValidInput) return;

    // if valid continue

    // if there is no image stop/return
    if (imageByte == null) {
      DInfo.toastError('Image jangan kosong');
      return;
    }

    // if have image continue
    Uri url = Uri.parse('${AppConstant.baseUrl}/asset/create.php');

    try {
      final response = await http.post(
        url,
        body: {
          'name': editName.text,
          'type': type,
          'image': imageName,
          'base64code': base64Encode(imageByte as List<int>),
        },
      );

      DMethod.printResponse(response);

      Map resBody = jsonDecode(response.body);
      bool success = resBody['success'] ?? false;
      if (success) {
        DInfo.toastSuccess('Success Create New Asset');
        Navigator.pop(context);
      } else {
        DInfo.toastError('Failed To Create New Asset');
      }
    } catch (e) {
      DMethod.printTitle('catch', e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Aset Baru'),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            DInput(
              title: 'Name',
              hint: 'Vas bunga',
              controller: editName,
              fillColor: Colors.white,
              validator: (input) => input == '' ? 'Jangan kosong' : null,
              radius: BorderRadius.circular(10),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Type',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            DropdownButtonFormField(
              value: type,
              icon: const Icon(Icons.keyboard_arrow_down),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              items: types.map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  type = value;
                }
              },
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Image',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(16),
                alignment: Alignment.center,
                child: imageByte == null
                    ? const Text('Empty')
                    : Image.memory(imageByte!),
              ),
            ),
            ButtonBar(
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    pickImage(ImageSource.camera);
                  },
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Camera'),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    pickImage(ImageSource.gallery);
                  },
                  icon: const Icon(Icons.image),
                  label: const Text('Galery'),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => save(),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
