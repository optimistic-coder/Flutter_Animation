import 'package:News_App/screens/DetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';
import 'dart:convert';
import 'package:date_format/date_format.dart';
import 'package:dio/dio.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];
final List<Widget> imageSliders = imgList
    .map((item) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    image: DecorationImage(
                        image: NetworkImage(item), fit: BoxFit.cover)),
              ),
              Container(
                  alignment: Alignment.bottomCenter,
                  height: 200.w,
                  width: 350.w,
                  decoration: BoxDecoration(
                    color: Color(0xB3000000).withOpacity(0.3),
                    borderRadius: BorderRadius.circular(15.w),
                  ),
                  child: Container(
                    margin: EdgeInsets.all(15),
                    child: Text(
                      "Cavani fires Uruguay into last eight as Ronaldo dream ends",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )),
            ],
          ),
        ))
    .toList();

//
class Business extends StatelessWidget {
  Future<List<News>> _getUsers() async {
    var dio = Dio();
    Response response = await dio.get(
        "http://newsapi.org/v2/everything?q=bitcoin&from=2020-07-08&sortBy=publishedAt&apiKey=586eaec9ea5f4280abcaca16aa423ceb");

    // return
    List<News> users = [];

    for (var u in response.data["articles"]) {
      News user = News(u["title"], u["url"], u["urlToImage"], u["description"],
          u["publishedAt"]);

      users.add(user);
    }
    // print(users);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              CarouselSlider(
                options: CarouselOptions(
                  height: 200,
                  autoPlay: true,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                ),
                items: imageSliders,
              ),
              Container(
                height: 600,
                child: FutureBuilder(
                    future: DefaultAssetBundle.of(context)
                        .loadString('Data/Data.json'),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      var mydata = json.decode(snapshot.data.toString());
                      // print(snapshot.data);
                      if (mydata == null) {
                        return Container(
                            child: Center(child: Text("Loading...")));
                      } else {
                        return ListView.builder(
                            itemCount: mydata.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailScreens(
                                              mydata[index]["id"].toString(),
                                              mydata[index]["title"],
                                              mydata[index]["urlToImage"],
                                              mydata[index]["description"],
                                              mydata[index]["publishedAt"],
                                              mydata[index]["cat"],
                                            )),
                                  );
                                },
                                child: Container(
                                  height: 100.w,
                                  margin: EdgeInsets.only(
                                      top: 15.w, right: 15.w, bottom: 5.w),
                                  decoration: BoxDecoration(
                                      color: Color(0xfffeffff),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(16),
                                          topRight: Radius.circular(16),
                                          bottomLeft: Radius.circular(16),
                                          bottomRight: Radius.circular(16)),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.08),
                                            blurRadius: 30.0,
                                            offset: Offset(1.0, 1),
                                            spreadRadius: 1)
                                      ]),
                                  child: Row(
                                    children: <Widget>[
                                      Hero(
                                          tag: mydata[index]["id"].toString(),
                                          child: Container(
                                            width: 80,
                                            height: 80,
                                            margin: EdgeInsets.only(left: 10.w),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(16),
                                                  topRight: Radius.circular(16),
                                                  bottomLeft:
                                                      Radius.circular(16),
                                                  bottomRight:
                                                      Radius.circular(16)),
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                    mydata[index]
                                                        ["urlToImage"]),
                                              ),
                                            ),
                                          )),
                                      Expanded(
                                          child: Container(
                                        margin: EdgeInsets.only(left: 8),
                                        child: Column(
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    left: 0, top: 15.w),
                                                child: Text(
                                                  mydata[index]["title"],
                                                  style: TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      fontSize: 13,
                                                      // fontWeight: FontWeight.,
                                                      color: Color(0xff3A476B),
                                                      fontFamily: "Poppins"),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                child: Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 10.w),
                                              child: Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Text(
                                                  mydata[index]["publishedAt"],
                                                  style: TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      fontSize: 11,
                                                      color: Color(0xffC4C4C4),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: "Poppins"),
                                                ),
                                              ),
                                            )),
                                          ],
                                        ),
                                      ))
                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  String convertDateFromString(String strDate) {
    final todayDate = DateTime.parse(strDate);
    return (formatDate(todayDate, [yyyy, ' - ', mm, ' - ', dd]));
  }

  String Title(String str, int length, ending) {
    if (length == null) {
      length = 60;
    }
    if (ending == null) {
      ending = '...';
    }
    if (str.length > length) {
      return str.substring(0, length - ending.length) + ending;
    } else {
      return str;
    }
  }
}

class News {
  final String title;
  final String url;
  final String urlToImage;
  final String description;
  final String publishedAt;
  News(this.title, this.url, this.urlToImage, this.description,
      this.publishedAt);
}
