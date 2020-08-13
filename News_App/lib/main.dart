import 'package:News_App/screens/DetailScreen.dart';
import 'package:News_App/screens/Search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import './screens/categories/World.dart';
import './screens/categories/Business.dart';
import './screens/categories/Tech.dart';
import './screens/categories/Sports.dart';
import './screens/categories/Entertain.dart';
import './screens/About.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:dio/dio.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
          // primarySwatch: Colors.grey
          primaryColor: Colors.white,
          primaryTextTheme:
              TextTheme(headline6: TextStyle(color: Colors.white))),
      home: MyApp(),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    //Set the fit size (fill in the screen size of the device in the design) If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)
    ScreenUtil.init(context, width: w, height: h, allowFontScaling: true);
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.white,
        // extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            "News",
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Search()));
                }),
          ],
        ),
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.

          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                  // child: Text('Drawer Header'),
                  decoration: BoxDecoration(
                color: Color(0xffFF4040),
                // image: DecorationImage(image: NetworkImage(""))
              )),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: Color(0xffFF4040),
                ),
                title: Text(
                  'Home',
                  style: TextStyle(
                      fontFamily: 'Poppins', fontWeight: FontWeight.w400),
                ),
                onTap: () {
                  // Update the state of the app.
                  // ...
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyApp()),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.assignment_late,
                  color: Color(0xffFF4040),
                ),
                title: Text('About',
                    style: TextStyle(
                        fontFamily: 'Poppins', fontWeight: FontWeight.w400)),
                onTap: () {
                  // Update the state of the app.
                  // ...
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => About()),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.share,
                  color: Color(0xffFF4040),
                ),
                title: Text('Invite Friends',
                    style: TextStyle(
                        fontFamily: 'Poppins', fontWeight: FontWeight.w400)),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
        ),
        body: SafeArea(
            child: Container(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10.w, left: 5.w),
                child: TabBar(
                  isScrollable: true,
                  indicatorPadding: EdgeInsets.only(left: 13.w),
                  indicatorColor: Color(0xffFF4040),
                  labelColor: Colors.black,
                  labelStyle: TextStyle(fontFamily: 'Poppins-Medium'),
                  tabs: [
                    Tab(text: "WORLD"),
                    Tab(text: "BUSINESS"),
                    Tab(text: "TECH"),
                    Tab(text: "SPORTS"),
                    Tab(text: "ENTERTAINMENT"),
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(left: 10.w),
                child: TabBarView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 30.w),
                      child: World(),
                    ),
                    Business(),
                    Tech(),
                    Sports(),
                    Entertain(),
                  ],
                ),
              ))
            ],
          ),
        )),
      ),
    );
  }
}

// class DataSearch extends SearchDelegate<String> {
//   Future<String> newss;
//   DataSearch(this.newss);
//   final news = ["tul", "joker", "krishna", "radhe", "akash", "aai"];
//   final recent = ["tul", "joker", "krishna", "radhe", "akash", "aai"];

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     // TODO: implement buildActions
//     print(newss);

//     return [Text("")];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     // TODO: implement buildLeading
//     return IconButton(
//         icon: AnimatedIcon(
//             icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
//         onPressed: () {
//           close(context, null);
//         });
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     // TODO: implement buildResults
//     // for (var i = 0; i <= news.length; i++) {
//     //   if (news[i] == query) {
//     //     return DetailScreen();
//     //   }
//     // }

//     return Text("els");
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // TODO: implement buildSuggestions
//     final suggestionList = query.isEmpty
//         ? recent
//         : news.where((p) => p.startsWith(query)).toList();
//     return ListView.builder(
//         itemCount: suggestionList.length,
//         itemBuilder: (context, index) => ListTile(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => DetailScreen()),
//                 );
//               },
//               leading: Icon(Icons.ac_unit),
//               title: RichText(
//                   text: TextSpan(
//                       text: suggestionList[index].substring(0, query.length),
//                       style: TextStyle(
//                           color: Colors.black, fontWeight: FontWeight.bold),
//                       children: [
//                     TextSpan(
//                         text: suggestionList[index].substring(query.length),
//                         style: TextStyle(color: Colors.grey))
//                   ])),
//             )); //9.23
//   }
// }
