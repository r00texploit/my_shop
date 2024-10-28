import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_shop/controllers/auth_controller.dart';
import 'package:my_shop/model/medicine_model.dart';
import 'package:my_shop/screens/cart.dart';
import 'package:my_shop/screens/details.dart';
import 'package:my_shop/screens/gender_page.dart';
import 'package:my_shop/widgets/bottom_nav_bar.dart';
import '../controllers/home_controller.dart';
import '../widgets/collection_box.dart';
import '../widgets/new_item.dart';
import '../widgets/popular_item.dart';
import 'color.dart';
import 'data.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MainController controller = Get.find();
  int _selectedIndex = 0; // Keep track of the selected index

  // List of screens to navigate to
  final List<Widget> _screens = [
    const HomeScreen(),
    // const SearchScreen(),
    CartPage(),
    // const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // Display the selected screen
      bottomNavigationBar: BottomNavigation(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped, // Handle item tap
      ),
    );
  }
}

// Sample screens for navigation
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: appBgColor,
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildBody(),
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
        backgroundColor: Colors.indigo,
        title: const Text('Home Screen'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                var auth = Get.put(AuthController());
                auth.signOut();
              })
        ]);
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          _buildPopularSection(),
          const SizedBox(height: 20),
          _buildNewItemsSection(),
        ],
      ),
    );
  }

  Widget _buildPopularSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Popular",
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
              fontSize: 24,
            ),
          ),
          _getPopulars(),
        ],
      ),
    );
  }

  Widget _buildNewItemsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "New",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
          getNewItems(),
        ],
      ),
    );
  }

  Widget _getPopulars() {
    return Obx(() {
      if (controller.products.isNotEmpty) {
        return CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            height: 370,
            enlargeCenterPage: true,
            disableCenter: true,
            viewportFraction: 0.75,
          ),
          items: List.generate(
            controller.products.length,
            (index) => PopularItem(
              data: controller.products[index],
              onTap: () {
                print(controller.products[index]);
                Get.to(() => Details(data1: controller.products[index]));
              },
            ),
          ),
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }

  Widget getNewItems() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(10),
      scrollDirection: Axis.horizontal,
      child: Row(
          children: List.generate(
              controller.products.length,
              (index) => Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: NewItem(
                    data: controller.products[index],
                    onTap: () {
                      Get.to(() => Details(data1: controller.products[index]));
                    },
                  )))),
    );
  }
}
