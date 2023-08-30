import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:course_asset_management/config/app_constant.dart';
import 'package:course_asset_management/models/asset_model.dart';
import 'package:course_asset_management/page/asset/create_asset_page.dart';
import 'package:course_asset_management/page/asset/search_asset_page.dart';
import 'package:course_asset_management/page/asset/update_asset_page.dart';
import 'package:course_asset_management/page/user/login_page.dart';
import 'package:d_info/d_info.dart';
import 'package:d_method/d_method.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Asset> assets = [];

  readAssets() async {
    assets.clear;

    Uri url = Uri.parse('${AppConstant.baseUrl}/asset/read.php');

    try {
      final response = await http.get(url);
      DMethod.printResponse(response);

      Map resBody = jsonDecode(response.body);
      bool success = resBody['success'] ?? false;

      if (success) {
        List data = resBody['data'];
        assets = data.map((e) => Asset.fromJson(e)).toList();
      }
      setState(() {});
    } catch (e) {
      DMethod.printTitle('catch', e.toString());
    }
  }

  showMenuItem(Asset item) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(item.name),
          children: [
            ListTile(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateAsset(
                      item: item,
                    ),
                  ),
                ).then((value) => readAssets());
              },
              horizontalTitleGap: 0,
              leading: const Icon(
                Icons.edit,
                color: Colors.blue,
              ),
              title: const Text('Update'),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                deleteAsset(item);
              },
              horizontalTitleGap: 0,
              leading: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              title: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  deleteAsset(Asset item) async {
    bool? isYes = await DInfo.dialogConfirmation(
      context,
      'Delete',
      'You sure want to delete ${item.name}?',
    );
    if (isYes ?? false) {
      Uri url = Uri.parse('${AppConstant.baseUrl}/asset/delete.php');

      try {
        final response = await http.post(
          url,
          body: {
            'id': item.id,
            'image': item.image,
          },
        );

        DMethod.printResponse(response);

        Map resBody = jsonDecode(response.body);
        bool success = resBody['success'] ?? false;
        if (success) {
          DInfo.toastSuccess('Success Delete Asset');
          readAssets();
        } else {
          DInfo.toastError('Failed To Delete Asset');
        }
      } catch (e) {
        DMethod.printTitle('catch', e.toString());
      }
    }
  }

  @override
  void initState() {
    readAssets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstant.appName),
        centerTitle: true,
        leading: PopupMenuButton(
          icon: const Icon(Icons.menu),
          onSelected: (value) {
            if (value == 'logout') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'logout',
              child: Text('Logout'),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchAssetPage(),
                ),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateAssetPage(),
            ),
          ).then((value) => readAssets());
        },
        child: const Icon(Icons.add),
      ),
      body: assets.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Empty'),
                  IconButton(
                    onPressed: () => readAssets(),
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              ),
            )
          : RefreshIndicator(
              onRefresh: () async => readAssets(),
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
                itemCount: assets.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  Asset item = assets[index];
                  return Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              imageUrl:
                                  '${AppConstant.baseUrl}/image/${item.image}',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    item.type,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Material(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.purple[50],
                              child: InkWell(
                                splashColor: Colors.purpleAccent,
                                onTap: () {
                                  showMenuItem(item);
                                },
                                borderRadius: BorderRadius.circular(4),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 4,
                                  ),
                                  child: Icon(
                                    Icons.more_vert,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}
