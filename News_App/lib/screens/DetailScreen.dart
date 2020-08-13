import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/Small_card.dart';

class DetailScreens extends StatefulWidget {
  final String id;
  final String title;
  final String urlToImage;
  final String description;
  final String publishedAt;
  final String cat;
  DetailScreens(this.id, this.title, this.urlToImage, this.description,
      this.publishedAt, this.cat);
  @override
  DetailScreen createState() =>
      new DetailScreen(id, title, urlToImage, description, publishedAt, cat);
}

class DetailScreen extends State<DetailScreens>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;
  Animation<Offset> offset;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    offset = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
        .animate(animationController);
  }

  final String id;
  final String title;
  final String urlToImage;
  final String description;
  final String publishedAt;
  final String cat;

  DetailScreen(this.id, this.title, this.urlToImage, this.description,
      this.publishedAt, this.cat);
  @override
  Widget build(BuildContext context) {
    // final double width = MediaQuery.of(context).size.width;

    animationController.forward();
    // TODO: implement build
    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget child) {
          return Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Hero(
                          tag: id,
                          child: Container(
                            height: 450.w,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                image: DecorationImage(
                                    image: NetworkImage(urlToImage),
                                    fit: BoxFit.cover)),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  margin:
                                      EdgeInsets.only(top: 40.w, left: 15.w),
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          )),
                      SlideTransition(
                        position: offset,
                        child: Transform(
                          transform: Matrix4.translationValues(0.0, -30.w, 0.0),
                          child: Container(
                            // height: 400.w,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.w),
                                    topRight: Radius.circular(30.w))),
                            child: Container(
                              margin: EdgeInsets.only(right: 20.w),
                              child: Column(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 20.w, top: 20.w),
                                      decoration: BoxDecoration(
                                          color: Color(0xffFFE558),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Container(
                                        margin: EdgeInsets.all(5),
                                        child: Text(
                                          cat,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 11,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 20.w, top: 10.w),
                                      child: Text(
                                        title,
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 18,
                                            decoration: TextDecoration.none,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: 10.w, left: 20.w),
                                      child: Text(
                                        description,
                                        style: TextStyle(
                                            decoration: TextDecoration.none,
                                            fontFamily: "Poppins",
                                            fontSize: 13,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 10.w, left: 20.w),
                                          child: Text(
                                            publishedAt,
                                            style: TextStyle(
                                                decoration: TextDecoration.none,
                                                fontFamily: "Poppins",
                                                fontSize: 13,
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                fontWeight: FontWeight.w200),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.topRight,
                                          margin: EdgeInsets.only(left: 220.w),
                                          child: Icon(Icons.share),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: 10.w, left: 20.w),
                                      child: Text(
                                        "Similar News",
                                        style: TextStyle(
                                            decoration: TextDecoration.none,
                                            fontFamily: "Poppins",
                                            fontSize: 13,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 15.w),
                                    child: SizedBox(
                                      height: 200,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: <Widget>[
                                          Small_card(),
                                          Small_card(),
                                          Small_card()
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ));
        });
  }
}
