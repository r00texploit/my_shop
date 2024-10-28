import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_shop/controllers/home_controller.dart';
import 'package:my_shop/widgets/custom_button.dart';

import '../widgets/CustomTextStyle.dart';
import '../widgets/CustomUtils.dart';
import 'checkout.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

MainController controller = Get.find();

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: Colors.indigo,
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade100,
      body: Builder(
        builder: (context) {
          return ListView(
            children: <Widget>[createCartList(), footer(context)],
          );
        },
      ),
    );
  }

  footer(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 30),
                child: Text(
                  "Total",
                  style: CustomTextStyle.textFormFieldMedium
                      .copyWith(color: Colors.grey, fontSize: 12),
                ),
              ),
              Obx(() {
                return Container(
                  margin: EdgeInsets.only(right: 30),
                  child: Text(
                    "${controller.totalPrice}\$",
                    style: CustomTextStyle.textFormFieldBlack.copyWith(
                        color: Colors.greenAccent.shade700, fontSize: 14),
                  ),
                );
              }),
            ],
          ),
          Utils.getSizedBox(height: 8, width: 0),
          controller.carts.value.isEmpty
              ? SizedBox()
              : CustomTextButton(
                  lable: 'Checkout',
                  ontap: () async {
                    // await controller.getAllUser();
                    // await controller.getSalary();
                    Get.to(() => CheckOut());
                  },
                  color: Colors.indigo),
          // RaisedButton(
          //   onPressed: () async {

          //   },
          //   color: Colors.indigo,
          //   padding: EdgeInsets.only(top: 12, left: 60, right: 60, bottom: 12),
          //   shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.all(Radius.circular(24))),
          //   child: Text(
          //     "Checkout",
          //     style: CustomTextStyle.textFormFieldSemiBold
          //         .copyWith(color: Colors.white),
          //   ),
          // ),
          Utils.getSizedBox(height: 8, width: 0),
        ],
      ),
      margin: EdgeInsets.only(top: 16),
    );
  }

  createHeader() {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        "Pharmacy CART",
        style: CustomTextStyle.textFormFieldBold
            .copyWith(fontSize: 16, color: Colors.black),
      ),
      margin: EdgeInsets.only(left: 12, top: 12),
    );
  }

  createSubTitle() {
    return Obx(() {
      return Container(
        alignment: Alignment.topLeft,
        child: Text(
          "Total(${controller.carts.value.length}) Items",
          style: CustomTextStyle.textFormFieldBold
              .copyWith(fontSize: 12, color: Colors.grey),
        ),
        margin: EdgeInsets.only(left: 12, top: 4),
      );
    });
  }

  createCartList() {
    return Obx(() {
      return controller.carts.value.isEmpty
          ? Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Center(
                child: Text(
                  'Empty Cart',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, position) {
                return Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                                right: 8, left: 8, top: 8, bottom: 8),
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14)),
                                color: Colors.blue.shade200,
                                image: DecorationImage(
                                    image: NetworkImage(
                                      controller.carts.value[position].image!,
                                    ),
                                    fit: BoxFit.cover)),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(right: 8, top: 4),
                                    child: Text(
                                      controller.carts.value[position].name!,
                                      maxLines: 2,
                                      softWrap: true,
                                      style: CustomTextStyle
                                          .textFormFieldSemiBold
                                          .copyWith(fontSize: 14),
                                    ),
                                  ),
                                  Utils.getSizedBox(height: 6, width: 0),
                                  Text(
                                    controller.carts.value[position].color!,
                                    style: CustomTextStyle.textFormFieldRegular
                                        .copyWith(
                                            color: Colors.grey, fontSize: 14),
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "${controller.carts.value[position].price}\$",
                                          style: CustomTextStyle
                                              .textFormFieldBlack
                                              .copyWith(color: Colors.green),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              GestureDetector(
                                                onTap: () {
                                                  if (controller
                                                          .carts
                                                          .value[position]
                                                          .count >
                                                      1) {
                                                    controller
                                                        .carts
                                                        .value[position]
                                                        .count -= 1;
                                                    controller.totalPrice -=
                                                        controller
                                                            .carts
                                                            .value[position]
                                                            .price!;
                                                  } else {
                                                    controller
                                                        .carts
                                                        .value[position]
                                                        .count = 1;
                                                  }
                                                  controller.carts.refresh();
                                                },
                                                child: Icon(
                                                  Icons.remove,
                                                  size: 24,
                                                  color: Colors.grey.shade700,
                                                ),
                                              ),
                                              GetX<MainController>(
                                                builder: (logic) {
                                                  return Container(
                                                    color: Colors.grey.shade200,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 2,
                                                            right: 12,
                                                            left: 12),
                                                    child: Text(
                                                      '${logic.carts.value[position].count}',
                                                      style: CustomTextStyle
                                                          .textFormFieldSemiBold,
                                                    ),
                                                  );
                                                },
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  controller
                                                      .carts
                                                      .value[position]
                                                      .count += 1;
                                                  controller.totalPrice +=
                                                      controller
                                                          .carts
                                                          .value[position]
                                                          .price!;
                                                  controller.carts.refresh();
                                                },
                                                child: Icon(
                                                  Icons.add,
                                                  size: 24,
                                                  color: Colors.grey.shade700,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            flex: 100,
                          )
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          controller.totalPrice -=
                              controller.carts.value[position].price! *
                                  controller.carts.value[position].count;
                          controller.carts.value.removeAt(position);
                          controller.carts.refresh();
                        },
                        child: Container(
                          width: 24,
                          height: 24,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(right: 10, top: 8),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 20,
                          ),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              color: Colors.red),
                        ),
                      ),
                    )
                  ],
                );
              },
              itemCount: controller.carts.value.length,
            );
    });
  }
}
//
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
//
// import '../constants.dart';
// import '../widgets/bottom_nav_bar.dart';
//
// class Cart extends StatelessWidget {
//   const Cart({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final data = MediaQuery.of(context);
//     final width = data.size.width;
//     final height = data.size.height;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cart'),
//         backgroundColor: Colors.indigo,
//       ),
//       body: Stack(
//         children:[ ListView.builder(itemBuilder: (BuildContext context, int index) {
//           return Container(
//             height: height / 5,
//             child: Card(
//               elevation: 5,
//               child: Row(
//                 children: [
//                   Image.network('https://images.unsplash.com/photo-1591047139829-d91aecb6caea?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fGNsb3RoZXN8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',height: 50,width: 70,),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'Dress',
//                         style: Theme.of(context).textTheme.headline6,
//                       ),
//                         Text(
//                           '200\$',
//                           style: Theme.of(context).textTheme.headline6,
//                         ),
//
//
//                     ],
//
//                   ),
//                   IconButton(
//                       onPressed: () {
//                         // controller.decrement(controller.numBed);
//                       },
//                       icon: const Icon(Icons.remove)),
//                   Center(
//                       child: Text(
//                         "1",
//                       )),
//                   IconButton(
//                       onPressed: () {
//                         // controller.increment(controller.numBed);
//                       },
//                       icon: const Icon(Icons.add)),
//                 ],
//               ),
//             ),
//           );
//         },),
//         Spacer(),
//           Center(
//             child: SizedBox(
//               width: 200,
//               height: 48,
//               child: ElevatedButton(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                     primary: Colors.indigo,
//                     shape: const StadiumBorder()),
//                 child: const Text("Add to Cart"),
//               ),
//             ),
//           ),
//           const SizedBox(height: defaultPadding * 2),
//         ]
//       ),
//     );
//   }
// }
