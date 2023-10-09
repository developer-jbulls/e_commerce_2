import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimatedListView(),
    );
  }
}

class AnimatedListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated ListView'),
      ),
      body: ListView.builder(
        itemCount: 50, // Replace with the number of list items you need
        itemBuilder: (BuildContext context, int index) {
          return AnimatedListItem(index: index);
        },
      ),
    );
  }
}

class AnimatedListItem extends StatefulWidget {
  final int index;

  AnimatedListItem({required this.index});

  @override
  _AnimatedListItemState createState() => _AnimatedListItemState();
}

class _AnimatedListItemState extends State<AnimatedListItem> {
  double itemHeight = 50.0; // Initial height of the ListTile

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      height: itemHeight, // Adjust the height values as needed
      color: Colors.blue, // Adjust the background color
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Item ${widget.index}',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                itemHeight = itemHeight == 50.0 ? 150.0 : 50.0;
              });
            },
            child: Text(
              itemHeight == 50.0 ? 'Tap to expand' : 'Tap to collapse',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
