// ///screen for card
import 'package:flutter/material.dart';

import 'homescreen/card1.dart';
import 'homescreen/card2.dart';
import 'homescreen/card3.dart';

void main() => runApp(MaterialApp(home: MyHomePage()));

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({Key? key}) : super(key: key);

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Container(
          child: Column(children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'you might need ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    'seeMore',
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SnappingList(),
            SizedBox(
              height: 30,
            ),
            SnappingList2(),
            SizedBox(
              height: 50,
            ),
            SnappingList3()
          ]),
        ),
      ),
    );
  }
}

List<String> icons = [
 'assets/icons/chicken.gif',
 'assets/icons/bread.gif',
  'assets/icons/dairy-products.gif',
  'assets/icons/bakery.gif',
  'assets/icons/fruits.gif',
  'assets/icons/nachos.gif',
  // 'assets/icons/bread.gif',
  // Icons.accessibility,
  // Icons.add,
  // Icons.add_alarm,
  // Icons.add_circle,
  // Icons.add_location,
];

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      pinned: true,
      elevation: 20,
      shadowColor: Colors.grey,
      expandedHeight: 250.0, // Height of the custom app bar
      flexibleSpace: Stack(
        children: [
          ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              color: Color(0xFF1F1F26),
            ),
          ),
          IconPageView(
            icons: icons,
          ),
          Positioned(
            bottom: 6,
            left: 0,
            right: 0,
            child: PageIndicator(
              pageCount: 2,
              currentPage: 0, // You can set the initial page here
            ),
          ),
          Positioned(
            top: 50.0,
            left: 16.0,
            right: 16.0,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 24.0,
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search',
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.shopping_cart,
                    color: Colors.black,
                    size: 24.0,
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
              bottom: 120,
              left: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      "Ahmedabad,Gujarat",
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomAppBar(),
          const SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: HomeScreen2(),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // Define the custom shape for the app bar
    final path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
/// code for scrolling tabbar in circle
class IconPageView extends StatelessWidget {
  const IconPageView({super.key, required this.icons});
  final List<String> icons;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 3,
      child: Container(
        color: Colors.transparent,
        height: 60,
        padding: EdgeInsets.all(5),
        child: PageView.builder(
          itemCount: 2, // You can adjust this based on your needs
          itemBuilder: (context, pageIndex) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int index = 3* pageIndex;
                    index < 3 * (pageIndex + 1);
                    index++)
                  Padding(
                    padding: EdgeInsets.all(1),
                    child: Container(
                      width: 95,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.amber.shade300,
                      ),
                      child: Center(
                        child: Image.asset(
                          icons[index % icons.length] ,fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// code for the page indicator for the circular tabBar in the appbar
class PageIndicator extends StatelessWidget {
  final int pageCount;
  final int currentPage;

  PageIndicator({
    required this.pageCount,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(pageCount, (index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            width: index == currentPage ? 20.0 : 10.0,
            height: 5.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.5),
              color: index == currentPage ? Colors.amber.shade300 : Colors.grey,
            ),
          );
        }),
      ),
    );
  }
}
