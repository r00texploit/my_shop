import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_shop/screens/register_view.dart';
import 'package:my_shop/widgets/background-image.dart';
import 'package:my_shop/widgets/custom_button.dart';
import 'package:my_shop/widgets/custom_textfield.dart';

import '../constants.dart';
import '../controllers/auth_controller.dart';
import '../widgets/custom_text.dart';

class LoginView extends StatelessWidget {
  final AuthController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Stack(
        children: [
          BackgroundImage(image: 'assets/images/123.png'),
          Form(
            key: controller.formKey,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 50,
                right: 20,
                left: 20,
              ),
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "Welcome,",
                        fontSize: 30,
                        color: Colors.white,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(RegisterView());
                        },
                        child: CustomText(
                          text: "Sign Up",
                          color: primaryColor,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomText(
                    text: 'Sign in to Continue',
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                    bol: false,
                      controller: controller.email,
                      validator: (validator) {
                        return controller.validateEmail(validator!);
                      },
                      lable: 'Email',
                      icon: Icon(
                        Icons.email,
                        color: Colors.white,
                      ),
                      input: TextInputType.emailAddress),
                  SizedBox(
                    height: 40,
                  ),
                  CustomTextField(
                    bol: true,
                      controller: controller.password,
                      validator: (validator) {
                        return controller.validatePassword(validator!);
                      },
                      lable: 'Password',
                      icon: Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                      input: TextInputType.text),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextButton(
                    lable: 'SIGN IN',
                    ontap: () {
                      controller.login();
                    },
                    color: primaryColor,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
