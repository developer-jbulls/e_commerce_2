import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

import '../descriptionScreen.dart';

List<Product> productList = [
  Product(
      'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpghttps://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg',
      'Black Chair',
      90,
      15),
  Product(
      "https://cdn.pixabay.com/photo/2016/05/05/02/37/sunset-1373171_960_720.jpg",
      'Awesome Sofa',
      100,
      10),
  Product(
      "https://cdn.pixabay.com/photo/2017/02/01/22/02/mountain-landscape-2031539_960_720.jpg",
      "Greenery",
      10,
      25),
  Product(
      "https://cdn.pixabay.com/photo/2014/09/14/18/04/dandelion-445228_960_720.jpg",
      'Orange Lamp',
      9,
      50),
  Product(
      "https://cdn.pixabay.com/photo/2017/12/17/19/08/away-3024773_960_720.jpg",
      'Comfortable Chair',
      15,
      5),
  Product(
      "https://cdn.pixabay.com/photo/2016/07/11/15/43/pretty-woman-1509956_960_720.jpg",
      'Simple Chair',
      20,
      7),
  Product(
      "https://cdn.pixabay.com/photo/2016/02/13/12/26/aurora-1197753_960_720.jpg",
      'Nice Lamp',
      14,
      10),
  Product(
      "https://cdn.pixabay.com/photo/2016/11/08/05/26/woman-1807533_960_720.jpg",
      'Awesome Planter',
      9,
      25),
  Product(
      "https://cdn.pixabay.com/photo/2013/11/28/10/03/autumn-219972_960_720.jpg",
      'Blue & white Sofa',
      50,
      43),
  Product(
      "https://cdn.pixabay.com/photo/2017/12/17/19/08/away-3024773_960_720.jpg",
      'White Planter',
      5,
      25),
];

class Product {
  final String imagePath;
  final String title;
  final double cost;
  final int reviewCount;

  Product(this.imagePath, this.title, this.cost, this.reviewCount);
}

class SnappingList2 extends StatefulWidget {
  const SnappingList2({Key? key}) : super(key: key);

  @override
  _SnappingList2State createState() => _SnappingList2State();
}

class _SnappingList2State extends State<SnappingList2> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ScrollSnapList(
        itemBuilder: _buildListItem,
        itemCount: productList.length,
        itemSize: 200,
        shrinkWrap: true, // Adjust the width of the card
        onItemFocus: (index) {},
        dynamicItemSize: true,
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    Product product = productList[index];
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDescriptionScreen(index: index),
            ));
      },
      child: SizedBox(
        width: 200, // Adjust the width of the card
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
                Image.network(
                  product.imagePath,
                  fit: BoxFit.cover,
                  width: 200, // Adjust the width of the image
                  height: 180,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  product.title,
                  style: const TextStyle(fontSize: 15),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${product.cost}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${product.reviewCount} Reviews',
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

class ProductDescriptionScreen extends StatelessWidget {
  const ProductDescriptionScreen({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          ProductDetailAppbar(),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: _buildProductDescription(context),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildProductDescription(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double targetImageHeight = screenHeight / 2.0;

    return Column(
      children: [
        // Background image or color
        Padding(
          padding: const EdgeInsets.all(28.0),
          child: Container(
            height: targetImageHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              image: DecorationImage(
                image: NetworkImage(productList[index]
                    .imagePath), // Replace with your product image
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        // Product information and description
        Container(
          padding: EdgeInsets.all(50.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productList[index].title,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
                'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 10.0),
              Text(
                'Price: \$ ${productList[index].cost}',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
