import 'package:flutter/material.dart';



class ProductDetailArc extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0, size.height)
      ..quadraticBezierTo(
        size.width / 2,
        size.height - 100,
        size.width,
        size.height,
      )
      ..lineTo(size.width, 0)
      ..lineTo(0, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class ProductDetailAppbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(title: const Text("Product Details"),
      elevation: 20,
      backgroundColor: Colors.transparent,
      pinned: true,
      automaticallyImplyLeading: true,
      expandedHeight: 100.0,
      flexibleSpace: ClipPath(
        clipper: ProductDetailArc(), // Use the custom clipper here
        child: Container(
          color: Color(0xFF1F1F26),
        ),
      ),
    );
  }
}




