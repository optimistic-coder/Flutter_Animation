import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Small_card extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
          decoration: BoxDecoration(),
          // margin: EdgeInsets.only(left: 20),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 40.w, right: 30.w),
                height: 100,
                width: 300,
                decoration: BoxDecoration(
                    color: Color(0xfffeffff),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Color(0xe5e6eb).withOpacity(0.6),
                          blurRadius: 30.0,
                          offset: Offset(1.0, 5),
                          spreadRadius: 5)
                    ]),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 80,
                      width: 80,
                      margin: EdgeInsets.only(left: 10.w, top: 10.w),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20.w),
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://ak4.picdn.net/shutterstock/videos/32281624/thumb/2.jpg'),
                              fit: BoxFit.cover)),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 8.w),
                      width: 180,
                      child: Text(
                        "Messi’s last chance for national glory slips away",
                        style: TextStyle(
                            fontSize: 10,
                            decoration: TextDecoration.none,
                            color: Colors.black,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w300),
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
