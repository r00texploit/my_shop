import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_shop/controllers/auth_controller.dart';
import 'package:my_shop/screens/add_product.dart';
import 'package:my_shop/screens/show_product.dart';

class Managment extends StatefulWidget {
  const Managment({Key? key}) : super(key: key);

  @override
  _ManagmentState createState() => _ManagmentState();
}

class _ManagmentState extends State<Managment> {
  AuthController auth = Get.find();
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    final width = data.size.width;
    final height = data.size.height;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(
          top: height / 7,
        ),
        padding: EdgeInsets.only(left: width / 8, right: width / 8),
        child: Center(
          child: GridView.count(
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              crossAxisCount: 2,
              childAspectRatio: .90,
              children: const [
                Card_d(
                  icon: Icon(Icons.shopping_cart_checkout_rounded,
                      size: 30, color: Colors.white),
                  title: 'Add Product',
                  nav: AddProduct(),
                ),
                Card_d(
                  icon: Icon(Icons.shopping_cart_checkout_rounded,
                      size: 30, color: Colors.white),
                  title: 'Show Products',
                  nav: ShowProduct(),
                ),
              ]),
        ),
      ),
    );
  }
}

class Card_d extends StatefulWidget {
  const Card_d(
      {Key? key, required this.title, required this.icon, required this.nav})
      : super(key: key);
  final String title;
  final dynamic icon;
  final dynamic nav;

  @override
  State<Card_d> createState() => _Card_dState();
}

// ignore: camel_case_types
class _Card_dState extends State<Card_d> {
  void showBar(BuildContext context, String msg) {
    var bar = SnackBar(
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(bar);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => widget.nav));
      },
      child: Card(
        color: Colors.blueAccent,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(child: widget.icon),
              const SizedBox(
                height: 10,
              ),
              Text(widget.title, style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
