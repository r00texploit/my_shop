import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_shop/controllers/home_controller.dart';
import 'package:my_shop/model/medicine_model.dart';
import 'package:search_page/search_page.dart';

import '../widgets/popular_item.dart';
import 'details.dart';

class GenderPage extends StatelessWidget {
  GenderPage({Key? key, required this.title}) : super(key: key);
  final String title;
  MainController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(title + ' Section :'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        tooltip: 'Search Medicine',
        onPressed: () => showSearch(
          context: context,
          delegate: SearchPage<Medicine>(
            searchStyle:
                TextStyle(color: Colors.green, backgroundColor: Colors.black),
            items: controller.genders,
            searchLabel: 'Search Medicine',
            suggestion: Center(
              child: Text('Filter Medicine by name, price '),
            ),
            failure: Center(
              child: Text('No Medicine found :('),
            ),
            filter: (person) => [
              person.name,
              person.price.toString(),
            ],
            builder: (person) => ListTile(
              onTap: () {
                Get.to(() => Details(
                      data1: person,
                    ));
              },
              title: Text('name: ' + person.name!),
              subtitle: Text('price:  ' + person.price!.toString()),
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            SizedBox(
              height: 50,
            ),
            getPopulars()
          ],
        ),
      ),
    );
  }

  getPopulars() {
    return controller.genders.isEmpty
        ? Center(
            child: Text('Not Available'),
          )
        : CarouselSlider(
            options: CarouselOptions(
              scrollDirection: Axis.vertical,
              height: 370,
              enlargeCenterPage: true,
              disableCenter: true,
              viewportFraction: .75,
            ),
            items: List.generate(
              controller.genders.length,
              (index) => PopularItem(
                data: controller.genders[index],
                onTap: () {
                  Get.to(() => Details(data1: controller.genders[index]));
                },
              ),
            ));
  }
}
