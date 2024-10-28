import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_shop/controllers/home_controller.dart';
import 'package:my_shop/model/user_model.dart';
import 'package:my_shop/screens/admin_page.dart';
import 'package:my_shop/screens/home.dart';

import '../screens/login_view.dart';
import '../widgets/loading.dart';
import '../widgets/snackbar.dart';

class AuthController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  late TextEditingController email,
      name,
      password,
      Rpassword,
      repassword,
      number,
      color,
      company,
      section,
      type;
  late TextEditingController product_name, price, description;

  bool ob = false;
  bool obscureTextLogin = true;
  bool obscureTextSignup = true;
  bool obscureTextSignupConfirm = true;
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  static FirebaseAuth auth = FirebaseAuth.instance;
  late CollectionReference collectionReference4;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  RxList<Users> users = RxList<Users>([]);
  late Widget route;
  @override
  void onReady() {
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
    super.onReady();
  }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    Rpassword = TextEditingController();
    repassword = TextEditingController();
    number = TextEditingController();
    name = TextEditingController();
    collectionReference4 = firebaseFirestore.collection("users");
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    // users.bindStream(getAllUser());
    // getAllUser();
    ever(_user, _initialScreen);
    super.onInit();
  }

  Stream<List<Users>> getAllUser() => collectionReference4
      .where('uid', isEqualTo: auth.currentUser!.uid)
      .snapshots()
      .map((query) => query.docs.map((item) => Users.fromMap(item)).toList());

  String? get user_ch => _user.value!.email;
  _initialScreen(User? user) {
    if (user == null) {
      route = LoginView();
    } else {
      users.bindStream(getAllUser());
      route = HomePage();
    }
  }

  late String uid;
  late int phone;
  getUser() async {
    String uid = auth.currentUser!.uid;
    var res = await collectionReference4.where('uid', isEqualTo: uid).get();
    if (res.docs.isNotEmpty) {
      print(res.docs.first['number']);
      phone = res.docs.first['number'];
      uid = res.docs.first['uid'];
    }
  }

  toggleLogin() {
    obscureTextLogin = !obscureTextLogin;

    update(['loginOb']);
  }

  toggleSignup() {
    obscureTextSignup = !obscureTextSignup;
    update(['reOb']);
  }

  toggleSignupConfirm() {
    obscureTextSignupConfirm = !obscureTextSignupConfirm;
    update(['RreOb']);
  }

  String? validate(String value) {
    if (value.isEmpty) {
      return "please enter your name";
    }

    return null;
  }

  String? validateNumber(String value) {
    if (value.isEmpty) {
      return "please enter your Phone";
    }
    if (value.length < 10) {
      return "Phone length must be more than 10";
    }
    if (value.length > 10) {
      return "Phone length must not be more than 10";
    }

    return null;
  }

  String? validateAddress(String value) {
    if (value.isEmpty) {
      return "Please Add All Field";
    }
    return null;
  }

  String? validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    if (value.isEmpty) {
      return "please enter your email";
    }

    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }

    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return "please enter your password";
    }
    if (value.length < 6) {
      return "password length must be more than 6 ";
    }
    return null;
  }

  String? validateRePassword(String value) {
    if (value.isEmpty) {
      return "please enter your password";
    }
    if (value.length < 6) {
      return "password length must be more than 6 ";
    }
    if (password.text != value) {
      return "password not matched ";
    }
    return null;
  }

  changeOb() {
    ob = !ob;
    update(['password']);
  }

  void signOut() async {
    Get.dialog(AlertDialog(
      content: const Text('Are you are sure to log out'),
      actions: [
        TextButton(
            onPressed: () async {
              MainController controller = Get.find();
              controller.carts.value.clear();
              await auth
                  .signOut()
                  .then((value) => Get.offAll(() => LoginView()));
            },
            child: const Text('YES')),
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('BACK'))
      ],
    ));
  }

  void register() async {
    if (formKey2.currentState!.validate()) {
      try {
        showdilog();

        final credential = await auth.createUserWithEmailAndPassword(
            email: email.text, password: password.text);
        credential.user!.updateDisplayName(name.text);
        await credential.user!.reload();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(credential.user!.uid)
            .set({
          'name': name.text,
          'email': email.text,
          'number': int.tryParse(number.text),
          'uid': credential.user!.uid,
        });
        await FirebaseFirestore.instance
            .collection('Bank')
            .doc(credential.user!.uid)
            .set({
          'name': name.text,
          'balance': 8000000000,
          'uid': credential.user!.uid,
        });
        Get.back();
        email.clear();
        password.clear();
        number.clear();
        name.clear();
        showbar("About User", "User message", "User Created!!", true);
      } on FirebaseAuthException catch (e) {
        Get.back();
        showbar("About User", "User message", e.toString(), false);
      }
    }
  }

  void login() async {
    if (formKey.currentState!.validate()) {
      try {
        showdilog();
        var user = await auth.signInWithEmailAndPassword(
            email: email.text, password: password.text);
        final userDoc = await FirebaseFirestore.instance
            .collection('user')
            .where('email', isEqualTo: email.text)
            .limit(1) // Limit to one document for efficiency
            .get();
        if (userDoc.docs.isNotEmpty) {
          Get.back();
          email.clear();
          password.clear();
          users.bindStream(getAllUser());
          Get.offAll(() => HomePage());
        } else {
          final adminDoc = await FirebaseFirestore.instance
              .collection('admin')
              .where('email', isEqualTo: email.text)
              .limit(1) // Limit to one document for efficiency
              .get();
          if (adminDoc.docs.isNotEmpty) {
            Get.back();
            email.clear();
            password.clear();
            Get.offAll(() => Managment());
          }
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Get.back();
          showbar("About Login", "Login message",
              "You dont have a Entry Permit", false);
        } else {
          Get.back();
          showbar("About Login", "Login message", e.toString(), false);
        }
      }
    }
  }

  void addProduct() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      update();
      return;
    } else {
      try {
        showdilog();
        await FirebaseFirestore.instance.collection('product').doc().set({
          "price": int.parse(price.text),
          "name": product_name.text,
          "color": color.text, // Assuming default color as red
          "company": company.text,
          "description": description.text,
          "image": await uploadImage(await pickImage()),
          "number": int.parse(number.text),
          "section": section.text,
          "type": type.text
        });
        Get.back();
        Get.back();
        showbar("Product Added", "Product Added", "Product Added ", true);
      } catch (e) {
        Get.back();
        showbar("Error", "Error", e.toString(), false);
      }
    }
  }

  Future<String> uploadImage(File? imageFile) async {
    try {
      String fileName = basename(imageFile!.path);
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('product_images/$fileName');
      UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception("Error uploading image: $e");
    }
  }

  Future<File?> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return File(image.path);
    } else {
      return null;
    }
  }
}
