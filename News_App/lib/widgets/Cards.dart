// Flutter code sample for ListTile

// Here is an example of an article list item with multiline titles and
// subtitles. It utilizes [Row]s and [Column]s, as well as [Expanded] and
// [AspectRatio] widgets to organize its layout.
//
// ![Custom list item b](https://flutter.github.io/assets-for-api-docs/assets/widgets/custom_list_item_b.png)

import 'dart:convert';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class Cards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DefaultAssetBundle.of(context)
            .loadString('../../../Data/Data.json'),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          var mydata = json.decode(snapshot.data.toString());
          if (mydata == null) {
            return Container(
              child: CircularProgressIndicator(),
            );
          } else {
            return Scaffold(
              body: AnimationLimiter(
                child: ListView.builder(
                  itemCount: mydata.length,
                  itemBuilder: (BuildContext context, int index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 875),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: GestureDetector(
                            child: Container(
                                height: 130.w,
                                margin: EdgeInsets.only(top: 15.w),
                                decoration: BoxDecoration(
                                  color: Color(0xffF7F7F9),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Hero(
                                        tag: mydata[index]["id"].toString(),
                                        child: Container(
                                          width: 140.w,
                                          height: 130.w,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(16),
                                                topRight: Radius.circular(16),
                                                bottomLeft: Radius.circular(16),
                                                bottomRight:
                                                    Radius.circular(16)),
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(
                                                  mydata[index]["avatar"]),
                                            ),
                                          ),
                                        )),
                                    Expanded(
                                        child: Container(
                                      margin: EdgeInsets.only(left: 8.w),
                                      child: Column(
                                        children: <Widget>[
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: 0, top: 10.w),
                                              child: Text(
                                                mydata[index]["name"],
                                                style: TextStyle(
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xff3A476B),
                                                    fontFamily: "Roboto"),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              child: Container(
                                            margin: EdgeInsets.only(top: 7.w),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                "South Indian",
                                                style: TextStyle(
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontSize: 12,
                                                    color: Color(0xB33A476B),
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Roboto-Light"),
                                              ),
                                            ),
                                          )),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  child: Text("Availble",
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                ),
                                                Container(
                                                  height: 23.w,
                                                  width: 50.w,
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      top: BorderSide(
                                                        color: Colors.green,
                                                        width: 1,
                                                      ),
                                                      left: BorderSide(
                                                        color: Colors.green,
                                                        width: 1,
                                                      ),
                                                      bottom: BorderSide(
                                                        color: Colors.green,
                                                        width: 1,
                                                      ),
                                                      right: BorderSide(
                                                        color: Colors.green,
                                                        width: 1,
                                                      ),
                                                    ),
                                                  ),
                                                  margin: EdgeInsets.only(
                                                      left: 70.w),
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      'ADD',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.green),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ))
                                  ],
                                )),
                            // onTap: () {
                            //   Navigator.push(context,
                            //       MaterialPageRoute(builder: (_) {
                            //     return DetailScreen();
                            //   }));
                            // },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }
        });
  }
}
