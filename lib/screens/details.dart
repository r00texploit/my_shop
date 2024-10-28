import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_shop/controllers/home_controller.dart';
import 'package:my_shop/model/cart_model.dart';
import 'package:my_shop/widgets/CustomTextStyle.dart';
import 'package:my_shop/widgets/snackbar.dart';

import '../constants.dart';
import '../model/medicine_model.dart';

class Details extends StatelessWidget {
  Details({
    Key? key,
    required this.data1,
  }) : super(key: key);
  final Medicine data1;

  @override
  Widget build(BuildContext context) {
    data1.printInfo();
    // log('id : ${data1.id}');
    // log('type : ${data1.type}');
    // log('name : ${data1.name}');
    // log('section : ${data1.section}');
    // log('description : ${data1.description}');
    // log('image : ${data1.image}');
    // log('price : ${data1.price}');
    // log('number : ${data1.number}');
    // log('color : ${data1.color}');
    // log('isFavorited : ${data1.isFavorited}');

    final data = MediaQuery.of(context);
    final width = data.size.width;
    final height = data.size.height;

    return Scaffold(
        body: ListView(
      children: [
        Stack(
          children: [
            Container(
              height: data.size.height * 0.5,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: data1.image!,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: CircularProgressIndicator(
                      value: downloadProgress.progress),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                width: 1000,
                height: 190,
              ),
            ),
            SizedBox(
              height: data.size.height * 0.50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.07, vertical: height * .07),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(Icons.arrow_back_ios,
                              color: Colors.white, size: 24),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: Center(
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: Text(
                    //         data1.name!,
                    //         style: Theme.of(context).textTheme.titleLarge,
                    //       ),
                    //     ),
                    //     const SizedBox(width: defaultPadding),
                    //     Text(
                    //       data1.price.toString() + '\$',
                    //       style: CustomTextStyle.textFormFieldBlack
                    //           .copyWith(color: Colors.green),
                    //     ),
                    //   ],
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(vertical: defaultPadding),
                    //   child: Text(data1.description.toString()),
                    // ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Product Name: ${data1.name}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // IconButton(
                        //     onPressed: () {
                        //       change(snapshot.data!.docs[index].id,
                        //           'name');
                        //     },
                        //     icon: Icon(Icons.edit))
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Price:  ${data1.price}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // IconButton(
                        //     onPressed: () {
                        //       change(snapshot.data!.docs[index].id,
                        //           'price');
                        //     },
                        //     icon: Icon(Icons.edit))
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Color:  ${data1.color}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // IconButton(
                        //     onPressed: () {
                        //       change(snapshot.data!.docs[index].id,
                        //           'color');
                        //     },
                        //     icon: Icon(Icons.edit))
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Company:  ${data1.section}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // IconButton(
                        //     onPressed: () {
                        //       // change(snapshot.data!.docs[index].id,
                        //       //     'company');
                        //     },
                        //     icon: Icon(Icons.edit))
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Wrap(
                            children: [
                              Text(
                                "Description:  ${data1.description}",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                softWrap: true,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: defaultPadding * 2),
                    Center(
                      child: SizedBox(
                        width: 200,
                        height: 48,
                        child: GetBuilder<MainController>(
                          builder: (logic) {
                            return ElevatedButton(
                              onPressed: () {
                                print(logic.carts.value);
                                print(
                                    "cart length : ${logic.carts.value.length}");
                                // var res = logic.carts.value.forEach((element) {
                                //   if (element.name == data1.name) {
                                //     showbar('Add To Cart', 'subtitle',
                                //         'ALREADY ADDED', true);
                                //   } else {
                                logic.addToCart(Cart(
                                    count: 1,
                                    type: data1.type,
                                    price: data1.price,
                                    color: data1.color,
                                    image: data1.image,
                                    name: data1.name,
                                    description: data1.description,
                                    number: data1.number));
                                logic.totalPrice += data1.price!;
                                showbar('Add To Cart', 'subtitle',
                                    'Added Successfully', true);
                                //   }
                                // });
                                print(logic.carts.value);
                                print(
                                    "cart length : ${logic.carts.value.length}");
                              },
                              style: ElevatedButton.styleFrom(
                                  textStyle:
                                      const TextStyle(color: Colors.white),
                                  backgroundColor: Colors.indigo,
                                  shape: const StadiumBorder()),
                              child: const Text("Add to Cart",
                                  style: TextStyle(color: Colors.white)),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
