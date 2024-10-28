import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:my_shop/model/user_model.dart';
import 'package:my_shop/screens/Bill.dart';
import 'package:my_shop/screens/home.dart';
import 'package:my_shop/widgets/loading.dart';
import 'package:my_shop/widgets/snackbar.dart';

import '../model/cart_model.dart';
import '../model/delivery_model.dart';
import '../model/medicine_model.dart';
import '../model/product_type_model.dart';

class MainController extends GetxController {
  RxList<Medicine> products = RxList<Medicine>([]);
  RxList<Delivery> delivery = RxList<Delivery>([]);
  RxList<Users> users = RxList<Users>([]);
  RxList<ProductType> productType = RxList<ProductType>([]);
  Rx<RxList<Cart>> carts = RxList<Cart>([]).obs;
  List pro = [];
  List<Medicine> genders = [];
  RxInt totalPrice = 0.obs;
  bool check = false;
  double location_lat = 0;
  double location_long = 0;
  int? number;
  late CollectionReference collectionReference;
  late CollectionReference collectionReference2;
  late CollectionReference collectionReference3;
  late CollectionReference collectionReference4;
  late CollectionReference collectionReference5;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  auth.User? user;
  @override
  void onInit() {
    user = FirebaseAuth.instance.currentUser;
    collectionReference = firebaseFirestore.collection("product");
    collectionReference2 = firebaseFirestore.collection("delivery");
    collectionReference3 = firebaseFirestore.collection("productType");
    collectionReference4 = firebaseFirestore.collection("users");
    collectionReference5 = firebaseFirestore.collection("payment");
    products.bindStream(getAllProduct());
    delivery.bindStream(getAllDelivery());
    // users.bindStream(getAllUsers());
    productType.bindStream(getAllProductType());
    super.onInit();
  }

  void addToCart(Cart cart) {
    carts.value.add(cart);
  }

  Stream<List<Medicine>> getAllProduct() => collectionReference.snapshots().map(
      (query) => query.docs.map((item) => Medicine.fromMap(item)).toList());

  Stream<List<Delivery>> getAllDelivery() =>
      collectionReference2.snapshots().map(
          (query) => query.docs.map((item) => Delivery.fromMap(item)).toList());

  Stream<List<ProductType>> getAllProductType() =>
      collectionReference3.snapshots().map((query) =>
          query.docs.map((item) => ProductType.fromMap(item)).toList());

  // Stream<List<Users>> getAllUsers() => collectionReference4
  //     .where('uid', isEqualTo: user!.uid)
  //     .snapshots()
  //     .map((query) => query.docs.map((item) => Users.fromMap(item)).toList());

  void getProductByType(String type) {
    pro.clear();
    products.forEach((element) {
      if (element.type == type) {
        pro.add(element);
      }
    });
  }

  void getProductByGender(String section) {
    genders.clear();
    products.forEach((element) {
      if (element.section == section) {
        genders.add(element);
      }
    });
  }

  late String uid;
  getAllUser() async {
    auth.User? user1 = FirebaseAuth.instance.currentUser;
    String uid = user1!.uid;
    var res = await collectionReference4.where('uid', isEqualTo: uid).get();
    if (res.docs.isNotEmpty) {
      number = res.docs[0]['number'];
      uid = res.docs[0]['uid'];
    }
  }

  void makePayment(int totalPrice) async {
    try {
      showdilog();
      {
        await FirebaseFirestore.instance
            .collection('payment')
            .doc()
            .set(({
              // "uid": user!.uid,
              "totalPrice": totalPrice,
              "time": DateTime.now()
            }))
            .whenComplete(() {
          // carts.value.clear();
          Get.back();
          showbar('payment', 'subtitle', 'payment successful', true);
          Get.offAll(() => Bill());
        });
      }
    } catch (e) {
      Get.back();
      showbar('payment', 'subtitle', e.toString(), false);
    }
  }
}
