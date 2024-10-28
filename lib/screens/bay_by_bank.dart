import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_shop/controllers/home_controller.dart';
import 'package:my_shop/screens/Bill.dart';
import 'package:my_shop/widgets/background-image.dart';
import 'package:my_shop/widgets/custom_button.dart';
import 'package:my_shop/widgets/custom_textfield.dart';

class BayByBank extends StatefulWidget {
  const BayByBank({Key? key}) : super(key: key);

  @override
  _BayByBankState createState() => _BayByBankState();
}

class _BayByBankState extends State<BayByBank> {
  TextEditingController rePrice = TextEditingController();
  TextEditingController bankName = TextEditingController();
  TextEditingController accountType = TextEditingController();
  TextEditingController accountNumber = TextEditingController();
  TextEditingController cardNumber = TextEditingController();
  TextEditingController price = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  MainController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bay By Bank'),
        backgroundColor: Colors.indigo,
      ),
      body: Stack(
        children: [
          BackgroundImage(image: 'assets/images/4.jpg'),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                // padding: EdgeInsets.all(20),
                width: 300,
                // height: 600,
                // color: Colors.black45,
                child: Form(
                  key: formKey,
                  child: ListView(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Center(child: Text('Full Price :' + controller.totalPrice.toString())),
                      CustomTextField(
                          bol: false,
                          controller: bankName,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please add bank name';
                            }
                            return null;
                          },
                          lable: 'Bank Name',
                          icon: Icon(Icons.account_box),
                          input: TextInputType.text),
                      CustomTextField(
                          bol: false,
                          controller: accountType,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please add account type';
                            }
                            return null;
                          },
                          lable: 'Account Type',
                          icon: Icon(Icons.account_box),
                          input: TextInputType.text),
                      CustomTextField(
                          bol: false,
                          controller: accountNumber,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please add bank number';
                            }
                            if (value.length < 12) {
                              return 'account number length must be more than 12';
                            }
                            return null;
                          },
                          lable: 'Account Number',
                          icon: Icon(Icons.numbers),
                          input: TextInputType.number),
                      CustomTextField(
                          bol: false,
                          controller: cardNumber,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please add bank number';
                            }
                            if (value.length < 12) {
                              return 'Card number length must be more than 12';
                            }
                            return null;
                          },
                          lable: 'Card Number',
                          icon: Icon(Icons.numbers),
                          input: TextInputType.number),
                      CustomTextField(
                          bol: false,
                          controller: price,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please add bank number';
                            }
                            return null;
                          },
                          lable: 'Price',
                          icon: Icon(Icons.numbers),
                          input: TextInputType.number),
                      CustomTextField(
                          bol: false,
                          controller: rePrice,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please add bank number';
                            }
                            if (value != price.text) {
                              return 'account number length must be more than 12';
                            }
                            return null;
                          },
                          lable: 'Re type Price',
                          icon: Icon(Icons.numbers),
                          input: TextInputType.number),
                      CustomTextButton(
                          lable: 'Make Payment',
                          ontap: () {
                            if (formKey.currentState!.validate()) {
                              controller
                                  .makePayment(controller.totalPrice.value);
                              // Get.to(() => Bill());
                            }
                          },
                          color: Colors.indigo)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
