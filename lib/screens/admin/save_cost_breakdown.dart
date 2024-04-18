import 'package:flutter/material.dart';

class ListViewExample extends StatelessWidget {
  const ListViewExample({
    super.key
    });

    @override
    Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('ListView Example', style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: Colors.blue[400],
            centerTitle: true,
          ),
          body: Container(
            padding: EdgeInsets.all(10),
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              children: const [
                Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.call, color: Colors.black, size: 30),
                      Text('Call', style: TextStyle(fontSize: 20, color: Colors.black)),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.route, color: Colors.black, size: 30),
                      Text('Route', style: TextStyle(fontSize: 20, color: Colors.black)),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.share, color: Colors.black, size: 30),
                      Text('Share', style: TextStyle(fontSize: 20, color: Colors.black)),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image, color: Colors.black, size: 30),
                      Text('Image', style: TextStyle(fontSize: 20, color: Colors.black)),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.call, color: Colors.black, size: 30),
                      Text('Call', style: TextStyle(fontSize: 20, color: Colors.black)),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.route, color: Colors.black, size: 30),
                      Text('Route', style: TextStyle(fontSize: 20, color: Colors.black)),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.share, color: Colors.black, size: 30),
                      Text('Share', style: TextStyle(fontSize: 20, color: Colors.black)),
                    ],
                  ),
                ),
              ],
            ),
          )
        );
    }
}