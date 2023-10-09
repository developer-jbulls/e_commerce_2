import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

import 'card2.dart';

List<Product1> productList1 = [
  Product1('assets/images/ui of appbar.PNG', 'Black Chair', 90, 15),
  Product1('assets/images/ui of card.PNG', 'Awesome Sofa', 100, 10),
  Product1('assets/images/ui of appbar.PNG', 'Copper Lamp', 10, 25),
  Product1('assets/images/ui of card.PNG', 'Orange Lamp', 9, 50),
  Product1('assets/images/ui of appbar.PNG', 'Comfortable Chair', 15, 5),
  Product1('assets/images/ui of card.PNG', 'Simple Chair', 20, 7),
  Product1('assets/images/ui of appbar.PNG', 'Nice Lamp', 14, 10),
  Product1('assets/images/ui of card.PNG', 'Awesome Planter', 9, 25),
  Product1('assets/images/ui of appbar.PNG', 'Blue & white Sofa', 50, 43),
  Product1('assets/images/ui of card.PNG', 'White Planter', 5, 25),
];

class Product1 {
  final String imagePath;

  final String title;

  final double cost;

  final int reviewCount;

  Product1(this.imagePath, this.title, this.cost, this.reviewCount);
}

class SnappingList extends StatefulWidget {
  const SnappingList({Key? key}) : super(key: key);

  @override
  _SnappingListState createState() => _SnappingListState();
}

class _SnappingListState extends State<SnappingList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ScrollSnapList(
        itemBuilder: _buildListItem,
        itemCount: productList1.length,
        itemSize: 150,
        onItemFocus: (index) {},
        dynamicItemSize: true,
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    Product1 product1 = productList1[index];
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDescriptionScreen(index: index),
            ));
      },
      child: SizedBox(
        width: 150,
        height: 250,
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(30.0), // Adjust border radius here
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            child: Column(
              children: [
                Image.asset(
                  product1.imagePath,
                  fit: BoxFit.cover,
                  width: 150,
                  height: 180,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  product1.title,
                  style: const TextStyle(fontSize: 15),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${product1.cost}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${product1.reviewCount} Reviews',
                        style: const TextStyle(color: Colors.blue),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
