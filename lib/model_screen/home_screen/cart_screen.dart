


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  final GestureTapCallback onTap;
  final String title;
  final String content;
  final String image;
  CartScreen({required this.onTap,required this.title,required this.content,required this.image});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children:
          [
            Expanded(
                flex: 1,
                child: Image.network(
                  "http://10.0.2.2:8080/corssphp/upload/${image}",
                  width: 80,
                  height: 80,
                  fit: BoxFit.fill,
                )
            ),
            Expanded(
              flex: 2,
              child: ListTile(
                title: Text('${title}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                subtitle: Text("${content}"),

              ),
            ),
          ],
        ),
      ),
    );
  }
}
