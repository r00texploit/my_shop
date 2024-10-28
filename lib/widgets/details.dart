import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  Details({Key? key, required this.data2}) : super(key: key);
  final dynamic data2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: <Widget>[
          hero(context),
          Container(
              child: Text(
                "A style icon gets some love from one of today's top "
                "trendsetters. Pharrell Williams puts his creative spin on these "
                "shoes, which have all the clean, classicdetails of the beloved Stan Smith.",
                textAlign: TextAlign.justify,
                style: TextStyle(height: 1.5, color: Color(0xFF6F8398)),
              ),
              padding: EdgeInsets.all(16)),
          Property(),
        ],
      ),
    ));
  }

  Widget appBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.asset("images/back_button.png"),
          Container(
            child: Column(
              children: <Widget>[
                Text(
                  "MEN'S ORIGINAL",
                  style: TextStyle(fontWeight: FontWeight.w100, fontSize: 14),
                ),
                Text(
                  "Smiths Shoes",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2F2F3E)),
                ),
              ],
            ),
          ),
          Image.asset(
            "images/bag_button.png",
            width: 27,
            height: 30,
          ),
        ],
      ),
    );
  }

  Widget hero(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Image.asset(
            "images/shoe_blue.png",
          ), //This
          // should be a paged
          // view.
          Positioned(
            child: appBar(context),
            top: 0,
          ),
          Positioned(
            child: FloatingActionButton(
                elevation: 2,
                child: Image.asset(
                  "images/heart_icon_disabled.png",
                  width: 30,
                  height: 30,
                ),
                backgroundColor: Colors.white,
                onPressed: () {}),
            bottom: 0,
            right: 20,
          ),
        ],
      ),
    );
  }

  Widget Property() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Color"),
              Row(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.red, shape: BoxShape.circle),
                    width: 30,
                    height: 30,
                    margin: EdgeInsets.all(5),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.green, shape: BoxShape.circle),
                    width: 30,
                    height: 30,
                    margin: EdgeInsets.all(5),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.yellow, shape: BoxShape.circle),
                    width: 30,
                    height: 30,
                    margin: EdgeInsets.all(5),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.pink, shape: BoxShape.circle),
                    width: 30,
                    height: 30,
                    margin: EdgeInsets.all(5),
                  ),
                ],
              )
            ],
          ),
          Column(
            children: <Widget>[
              Text("Size"),
              Text(
                "10.1",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2F2F3E)),
              )
            ],
          )
        ],
      ),
    );
  }
}
