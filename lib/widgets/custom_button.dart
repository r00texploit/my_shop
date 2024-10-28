import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    Key? key,
    required this.lable,
    required this.ontap,
    required this.color,
  }) : super(key: key);
  final String lable;
  final Function()? ontap;
  final Color color;
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    final width = data.size.width;
    final height = data.size.height;
    return TextButton(
      style: ButtonStyle(
          padding: WidgetStateProperty.all(EdgeInsets.only(
              top: height / 70,
              bottom: height / 70,
              left: width / 10,
              right: width / 10)),
          backgroundColor: WidgetStateProperty.all(color),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                  side: BorderSide(color: color)))),
      onPressed: ontap,
      child: Text(
        lable,
        style: const TextStyle(fontSize: 20.0, color: Colors.white),
      ),
    );
  }
}
