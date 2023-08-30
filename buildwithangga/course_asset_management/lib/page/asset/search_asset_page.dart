import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:course_asset_management/config/app_constant.dart';
import 'package:course_asset_management/models/asset_model.dart';
import 'package:course_asset_management/page/asset/create_asset_page.dart';
import 'package:d_method/d_method.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchAssetPage extends StatefulWidget {
  const SearchAssetPage({super.key});

  @override
  State<SearchAssetPage> createState() => _SearchAssetPageState();
}

class _SearchAssetPageState extends State<SearchAssetPage> {
  List<Asset> assets = [];
  final editSearch = TextEditingController();

  searchAssets() async {
    assets.clear;

    if (editSearch.text == '') {
      DMethod.printBasic('Stop no Input');
      return;
    }

    Uri url = Uri.parse('${AppConstant.baseUrl}/asset/search.php');

    try {
      final response = await http.post(
        url,
        body: {
          'search': editSearch.text,
        },
      );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.purple[100],
            borderRadius: BorderRadius.circular(30),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            controller: editSearch,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Search Here',
              isDense: true,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => searchAssets(),
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
          ).then((value) => searchAssets());
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
                    onPressed: () => searchAssets(),
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              ),
            )
          : GridView.builder(
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
                );
              },
            ),
    );
  }
}
