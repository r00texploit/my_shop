import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../controllers/auth_controller.dart';
import '../widgets/background-image.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_textfield.dart';

class RegisterView extends StatelessWidget {
  RegisterView({Key? key}) : super(key: key);
  final AuthController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      // appBar: AppBar(
      //   backgroundColor: Colors.indigo,
      //   elevation: 0.0,
      // ),
      body: Stack(
        children: [
          BackgroundImage(image: 'assets/images/123.png'),
          Form(
            key: controller.formKey2,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 30,
                right: 20,
                left: 20,
              ),
              child: ListView(
                children: [
                  CustomText(
                    text: "Sign Up,",
                    fontSize: 30,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: controller.name,
                    validator: (validator) {
                      return controller.validate(validator!);
                    },
                    lable: 'Name',
                    icon: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    input: TextInputType.text,
                    bol: false,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                      bol: false,
                      controller: controller.email,
                      validator: (validator) {
                        return controller.validateEmail(validator!);
                      },
                      lable: 'Email',
                      icon: const Icon(
                        Icons.email,
                        color: Colors.white,
                      ),
                      input: TextInputType.emailAddress),
                  CustomTextField(
                      bol: false,
                      controller: controller.number,
                      validator: (validator) {
                        return controller.validateNumber(validator!);
                      },
                      lable: 'Phone Number',
                      icon: const Icon(
                        Icons.call,
                        color: Colors.white,
                      ),
                      input: TextInputType.number),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                      bol: true,
                      controller: controller.password,
                      validator: (validator) {
                        return controller.validatePassword(validator!);
                      },
                      lable: 'Password',
                      icon: const Icon(
                        Icons.email,
                        color: Colors.white,
                      ),
                      input: TextInputType.number),
                  CustomTextField(
                      bol: true,
                      controller: controller.repassword,
                      validator: (validator) {
                        return controller.validateRePassword(validator!);
                      },
                      lable: 'Re-Type Password',
                      icon: const Icon(
                        Icons.email,
                        color: Colors.white,
                      ),
                      input: TextInputType.number),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextButton(
                    lable: 'SIGN Up',
                    ontap: () {
                      controller.register();
                    },
                    color: primaryColor,
                  ),
                  const SizedBox(
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
