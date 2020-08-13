import 'dart:convert';
import 'dart:io';

import 'package:News_App/main.dart';
import 'package:News_App/screens/DetailScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:search_widget/search_widget.dart';

// Sets a platform override for desktop to avoid exceptions. See
// https://flutter.dev/desktop#target-platform-override for more info.
void enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<News>> _getUsers() async {
    var myData = DefaultAssetBundle.of(context).loadString('Data/Data.json');
    var myJson = json.decode(myData.toString());
    // return
    print("object");

    print(myData);

    List<News> list = [];

    for (var u in myJson) {
      News user = News(u["id"], u["title"], u["urlToImage"], u["description"],
          u["publishedAt"], u["cat"]);

      list.add(user);
    }
    // print(list);
    return list;
  }

  News _selectedItem;

  bool _show = true;

  @override
  Widget build(BuildContext context) {
    // _getUsers();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Search Widget",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: FutureBuilder(
          future: DefaultAssetBundle.of(context).loadString('Data/Data.json'),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // List<News> newsss =
            // List<News> countries =parseJson(snapshot.data.toString()),
            var mydata = json.decode(snapshot.data.toString());
            List<News> list = [];

            for (var u in mydata) {
              News user = News(u["id"], u["title"], u["urlToImage"],
                  u["description"], u["publishedAt"], u["cat"]);

              list.add(user);
            }
            if (mydata == null) {
              return Container(child: Center(child: Text("Loading...")));
            } else {
              return SafeArea(
                  child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 16,
                    ),
                    if (_show)
                      SearchWidget<News>(
                        dataList: list,
                        hideSearchBoxWhenItemSelected: false,
                        listContainerHeight:
                            MediaQuery.of(context).size.height / 4,
                        queryBuilder: (query, list) {
                          return list
                              .where((item) => item.title
                                  .toLowerCase()
                                  .contains(query.toLowerCase()))
                              .toList();
                        },
                        popupListItemBuilder: (item) {
                          return PopupListItemWidget(item);
                        },
                        selectedItemBuilder:
                            (selectedItem, deleteSelectedItem) {},
                        // widget customization
                        noItemsFoundWidget: NoItemsFound(),
                        textFieldBuilder: (controller, focusNode) {
                          return MyTextField(controller, focusNode);
                        },
                        onItemSelected: (item) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailScreens(
                                    item.id.toString(),
                                    item.title,
                                    item.urlToImage,
                                    item.description,
                                    item.publishedAt,
                                    item.cat)),
                          );
                        },
                      ),
                    const SizedBox(
                      height: 32,
                    ),
                    Text(
                      "${_selectedItem != null ? _selectedItem.title : ""
                          "No item selected"}",
                    ),
                  ],
                ),
              ));
            }
          }),
    );
  }
}

class News {
  News(this.id, this.title, this.urlToImage, this.description, this.publishedAt,
      this.cat);
  final int id;
  final String title;
  final String urlToImage;
  final String description;
  final String publishedAt;
  final String cat;
}

class MyTextField extends StatelessWidget {
  const MyTextField(this.controller, this.focusNode);

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0x4437474F),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          suffixIcon: Icon(Icons.search),
          border: InputBorder.none,
          hintText: "Search here...",
          contentPadding: const EdgeInsets.only(
            left: 16,
            right: 20,
            top: 14,
            bottom: 14,
          ),
        ),
      ),
    );
  }
}

class NoItemsFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.folder_open,
          size: 24,
          color: Colors.grey[900].withOpacity(0.7),
        ),
        const SizedBox(width: 10),
        Text(
          "No Items Found",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[900].withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}

class PopupListItemWidget extends StatelessWidget {
  const PopupListItemWidget(this.item);

  final News item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Text(
        item.title,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
