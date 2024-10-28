// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:icon_badge/icon_badge.dart';
// import 'package:my_shop/controllers/home_controller.dart';
// import 'package:my_shop/screens/cart.dart';
// import 'package:my_shop/screens/home/home_screen.dart';

// import '../constants.dart';

// class MainScreen extends StatelessWidget {
//   const MainScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final data = MediaQuery.of(context);
//     final height = data.size.height;
//     return Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: const Text('My Shop',
//               style: TextStyle(fontSize: 18, color: Colors.white)),
//           backgroundColor: Colors.indigo,
//           actions: [
//             GetX<MainController>(
//               builder: (logic) {
//                 return IconBadge(
//                   icon: const Icon(Icons.shopping_cart),
//                   itemCount: logic.carts.value.length,
//                   badgeColor: Colors.red,
//                   itemColor: Colors.white,
//                   onTap: () {
//                     Get.to(() => CartPage());
//                   },
//                 );
//               },
//             ),
//           ],
//         ),
//         backgroundColor: Colors.indigo,
//         body: Padding(
//           padding: EdgeInsets.only(top: height / 7),
//           child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
//             Text(
//               "Explore",
//               style: Theme.of(context)
//                   .textTheme
//                   .headline4!
//                   .copyWith(fontWeight: FontWeight.w500, color: Colors.white),
//             ),
//             const Text(
//               "best Product for you",
//               style: TextStyle(fontSize: 18, color: Colors.white),
//             ),
//             SizedBox(
//               height: defaultPadding,
//             ),
//             Container(
//               height: height / 2,
//               child: GetX<MainController>(
//                 builder: (logic) {
//                   return logic.productType.isEmpty
//                       ? Center(
//                           child: Text('No Available Products'),
//                         )
//                       : GridView.builder(
//                           itemCount: logic.productType.length,
//                           gridDelegate:
//                               const SliverGridDelegateWithMaxCrossAxisExtent(
//                                   maxCrossAxisExtent: 250,
//                                   childAspectRatio: 2,
//                                   crossAxisSpacing: 0,
//                                   mainAxisSpacing: 0),
//                           itemBuilder: (BuildContext context, int index) {
//                             return Card_d(
//                               icon: logic.productType[index].image!,
//                               title: logic.productType[index].type!,
//                               type: logic.productType[index].type!,
//                               nav: HomeScreen(
//                                 title: logic.productType[index].type!,
//                               ),
//                             );
//                           });
//                 },
//               ),
//             ),
//           ]),
//         ));
//   }
// }

// class Card_d extends StatelessWidget {
//   Card_d(
//       {Key? key,
//       required this.title,
//       required this.icon,
//       required this.nav,
//       required this.type})
//       : super(key: key);
//   final String title;
//   final String icon;
//   final String type;
//   final dynamic nav;
//   MainController controller = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         controller.getProductByType(type);
//         Get.to(nav);
//       },
//       child: Container(
//         height: 250,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8),
//           color: Colors.indigo,
//         ),

//         // elevation: 2,
//         // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Center(
//                 child: CircleAvatar(
//                   backgroundColor: Colors.white,
//                   maxRadius: 30,
//                   backgroundImage: NetworkImage(icon),
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Text(title, style: const TextStyle(color: Colors.white)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
