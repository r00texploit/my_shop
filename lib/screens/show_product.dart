import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_shop/widgets/custom_button.dart';
import 'package:my_shop/widgets/loading.dart';
import 'package:my_shop/widgets/snackbar.dart';

class ShowProduct extends StatefulWidget {
  const ShowProduct({Key? key}) : super(key: key);

  @override
  State<ShowProduct> createState() => _ShowProductState();
}

class _ShowProductState extends State<ShowProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Products'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('product').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text('No Available data',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Wrap(
                                        children: [
                                          Text(
                                            "Product Name:  ${snapshot.data!.docs[index]['company']}",
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
                                    IconButton(
                                        onPressed: () {
                                          change(snapshot.data!.docs[index].id,
                                              'company');
                                        },
                                        icon: Icon(Icons.edit))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Price:  ${snapshot.data!.docs[index]['price']}",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          change(snapshot.data!.docs[index].id,
                                              'price');
                                        },
                                        icon: Icon(Icons.edit))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Color:  ${snapshot.data!.docs[index]['color']}",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          change(snapshot.data!.docs[index].id,
                                              'color');
                                        },
                                        icon: Icon(Icons.edit))
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Wrap(
                                        children: [
                                          Text(
                                            "Company:  ${snapshot.data!.docs[index]['company']}",
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
                                    IconButton(
                                        onPressed: () {
                                          change(snapshot.data!.docs[index].id,
                                              'company');
                                        },
                                        icon: Icon(Icons.edit))
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Wrap(
                                        children: [
                                          Text(
                                            "Description:  ${snapshot.data!.docs[index]['description']}",
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
                                    IconButton(
                                        onPressed: () {
                                          change(snapshot.data!.docs[index].id,
                                              'description');
                                        },
                                        icon: Icon(Icons.edit))
                                  ],
                                ),
                                Center(
                                  child: CustomTextButton(
                                      lable: 'Delete',
                                      ontap: () async {
                                        setState(() {
                                          showdilog();
                                        });
                                        try {
                                          await FirebaseFirestore.instance
                                              .collection('product')
                                              .doc(
                                                  snapshot.data!.docs[index].id)
                                              .delete();
                                          setState(() {
                                            Get.back();
                                            showbar(
                                                'Delete Product',
                                                'Subtitle',
                                                'Product deleted successfully',
                                                true);
                                          });
                                        } catch (e) {
                                          setState(() {
                                            Get.back();
                                            showbar(
                                                'Delete Product',
                                                'Subtitle',
                                                e.toString(),
                                                false);
                                          });
                                        }
                                      },
                                      color: Colors.red),
                                )
                              ],
                            ),
                          );
                        });
                  }
                }
              })),
    );
  }

  void change(String id, String field) async {
    TextEditingController change = TextEditingController();
    Get.defaultDialog(
        title: 'Edit',
        content: SingleChildScrollView(
          child: TextFormField(
            controller: change,
            decoration: const InputDecoration(
              icon: Icon(Icons.edit),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "This field cannot be empty";
              }
              return null;
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              showdilog();
              try {
                await FirebaseFirestore.instance
                    .collection('product')
                    .doc(id)
                    .update({field: change.text});
                change.clear();
                Get.back();
                Get.back();
                Get.snackbar('Update Successful',
                    'The product has been updated successfully',
                    backgroundColor: Colors.greenAccent);
              } catch (e) {
                Get.back();
                Get.back();
                Get.snackbar('Update Failed', e.toString(),
                    backgroundColor: Colors.red);
              }
            },
            child: const Text(
              "Edit",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          TextButton(
              onPressed: () {
                Get.back();
                change.clear();
              },
              child: const Text(
                "Exit",
                style: TextStyle(color: Colors.black, fontSize: 20),
              )),
        ]);
  }
}
