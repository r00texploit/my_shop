import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped; // Callback function

  const BottomNavigation({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.indigo, // Background color
      height: 60, // Set a fixed height
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, 'Home', 0),
          // _buildNavItem(Icons.search, 'Search', 1),
          _buildNavItem(Icons.shopping_cart, 'Cart', 1),
          // _buildNavItem(Icons.person, 'Profile', 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = index == selectedIndex; // Check if this item is selected
    return GestureDetector(
      onTap: () => onItemTapped(index), // Call the callback on tap
      child: Column(
        mainAxisSize: MainAxisSize.min, // Avoid overflow
        children: [
          Icon(icon,
              size: 24, color: isSelected ? Colors.yellow : Colors.white),
          const SizedBox(height: 4), // Space between icon and label
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.yellow : Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
