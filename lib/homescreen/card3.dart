import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

import 'card2.dart';

List<Product3> productList3 = [
  Product3('assets/images/ui of appbar.PNG', 'Black Chair', 90, 15),
  Product3('assets/images/ui of card.PNG', 'Awesome Sofa', 100, 10),
  Product3('assets/images/ui of appbar.PNG', 'Copper Lamp', 10, 25),
  Product3('assets/images/ui of card.PNG', 'Orange Lamp', 9, 50),
  Product3('assets/images/ui of appbar.PNG', 'Comfortable Chair', 15, 5),
  Product3('assets/images/ui of card.PNG', 'Simple Chair', 20, 7),
  Product3('assets/images/ui of appbar.PNG', 'Nice Lamp', 14, 10),
  Product3('assets/images/ui of card.PNG', 'Awesome Planter', 9, 25),
  Product3('assets/images/ui of appbar.PNG', 'Blue & white Sofa', 50, 43),
  Product3('assets/images/ui of card.PNG', 'White Planter', 5, 25),
];

class Product3 {
  final String imagePath3;

  final String title3;

  final double cost3;

  final int reviewCount3;

  Product3(this.imagePath3, this.title3, this.cost3, this.reviewCount3);
}

class SnappingList3 extends StatefulWidget {
  const SnappingList3({Key? key}) : super(key: key);

  @override
  _SnappingList3State createState() => _SnappingList3State();
}

class _SnappingList3State extends State<SnappingList3> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ScrollSnapList(
        itemBuilder: _buildListItem,
        itemCount: productList3.length,
        itemSize: 150,
        onItemFocus: (index) {},
        dynamicItemSize: true,
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    Product3 product3 = productList3[index];
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
                  product3.imagePath3,
                  fit: BoxFit.cover,
                  width: 150,
                  height: 180,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  product3.title3,
                  style: const TextStyle(fontSize: 15),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${product3.cost3}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${product3.reviewCount3} Reviews',
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
