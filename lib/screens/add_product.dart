import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_shop/controllers/home_controller.dart';
import 'package:my_shop/widgets/custom_textfield.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
        init: MainController(),
        builder: (auth) {
          return Scaffold(
            backgroundColor: Colors.indigo,
            appBar: AppBar(
              title: const Text('Add Product'),
            ),
            resizeToAvoidBottomInset: false,
            body: form(context, auth),
          );
        });
  }
}

Widget form(BuildContext context, MainController auth) {
  var height = MediaQuery.of(context).size.height;
  var width = MediaQuery.of(context).size.width;
  return Form(
    key: auth.formKey,
    child: Container(
        decoration: const BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(46),
            topRight: Radius.circular(46),
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.only(top: 5),
          children: [
            Column(
              children: [
                const SizedBox(height: 10),
                CustomTextField(
                  controller: auth.product_name,
                  validator: (value) {
                    return auth.validateAddress(value!);
                  },
                  lable: 'Product name',
                  icon: const Icon(Icons.shopping_cart_outlined),
                  input: TextInputType.text,
                  bol: false,
                ),
                CustomTextField(
                  controller: auth.price,
                  validator: (value) {
                    return auth.validateAddress(value!);
                  },
                  lable: 'Price',
                  icon: const Icon(Icons.price_change),
                  input: TextInputType.number,
                  bol: false,
                ),
                CustomTextField(
                  controller: auth.color,
                  validator: (value) {
                    return auth.validateAddress(value!);
                  },
                  lable: 'Color',
                  icon: const Icon(Icons.color_lens),
                  input: TextInputType.text,
                  bol: false,
                ),
                CustomTextField(
                  controller: auth.company,
                  validator: (value) {
                    return auth.validateAddress(value!);
                  },
                  lable: 'Company',
                  icon: const Icon(Icons.business),
                  input: TextInputType.text,
                  bol: false,
                ),
                CustomTextField(
                  controller: auth.description,
                  validator: (value) {
                    return auth.validateAddress(value!);
                  },
                  lable: 'Description',
                  icon: const Icon(Icons.description),
                  input: TextInputType.text,
                  bol: false,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextButton(
                      onPressed: () async {
                        if (auth.formKey.currentState!.validate()) {
                          auth.addProduct();
                        }
                      },
                      style: ButtonStyle(
                        padding: WidgetStateProperty.all(EdgeInsets.only(
                            top: height / 55,
                            bottom: height / 55,
                            left: width / 10,
                            right: width / 10)),
                        backgroundColor: WidgetStateProperty.all(
                            const Color.fromRGBO(19, 26, 44, 1.0)),
                        shape:
                            WidgetStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(13),
                                    side: const BorderSide(
                                        color:
                                            Color.fromRGBO(19, 26, 44, 1.0)))),
                      ),
                      child: const Text(
                        'Save',
                        style: TextStyle(fontSize: 16),
                      )),
                )
              ],
            ),
          ],
        )),
  );
}
