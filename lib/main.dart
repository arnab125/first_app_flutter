import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Text('App Name', style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.blue[400],
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              imageSection(),
              introSection(),
              iconSection(),
              paragraphSection(),
            ],
          ),
        ));
  }

  Widget paragraphSection() {
    return const Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Text(
                  'bjugygy ig ugugug uigu ugu ug ugu ugu guu uug ufufufydytyrtfc guu uug ufufufydytyrtfc uuy yuftu guu uug ufufufydytyrtfc uuy yuftu guu uug ufufufydytyrtfc uuy yuftu guu uug ufufufydytyrtfc uuy yuftu uuy yuftuycyuc tt rxr ffy dtxr xrxhcyx r zrz gc td',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black)),
            );
  }

  Widget iconSection() {
    return Container(
      padding: EdgeInsets.all(14),
      margin: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.blue[700],
        borderRadius: BorderRadius.circular(16),

      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Icon(Icons.call, color: Colors.black, size: 30),
              Text('Call', style: TextStyle(color: Colors.black, fontSize: 15)),
            ],
          ),
          Column(
            children: [
              Icon(Icons.route, color: Colors.black, size: 30),
              Text('Route', style: TextStyle(color: Colors.black, fontSize: 15)),
            ],
          ),
          Column(
            children: [
              Icon(Icons.share, color: Colors.black, size: 30),
              Text('Share', style: TextStyle(color: Colors.black, fontSize: 15)),
            ],
          ),
        ],
      ),
    );
  }

  Widget introSection() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const Text('Hello, This is a title',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(
                'This is a subtitle',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            ],
          ),
          const Column(
            children: [
              Row(
                children: [
                  Icon(Icons.star, color: Colors.orange, size: 25),
                  Text('41',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget imageSection() {
    return Image.network(
        "https://th.bing.com/th/id/R.fc99a71a82f12b952de000fcb6f9aa8c?rik=wQETi0Tsj4Aj2Q&riu=http%3a%2f%2fproject4gallery.com%2fwp-content%2fuploads%2f2016%2f03%2fbeautiful-nature-landscape-scenery-wide-5.jpg&ehk=9s5N2AWmjrEP%2fm7v%2fzbFZ%2b61XINT5u%2bVI8zoVd%2fRv%2bI%3d&risl=&pid=ImgRaw&r=0",
        width: double.infinity,
        height: 400,
        fit: BoxFit.cover);
  }
}
