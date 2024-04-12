import 'package:flutter/material.dart';

class CounterApp extends StatefulWidget {
  
  CounterApp({
    super.key
    });

  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
    int _counter = 0;

    @override
    Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Counter App', style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: Colors.blue[400],
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('You have pushed the button this many times:', style: TextStyle(fontSize: 16)),
                Text('$_counter', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _increament,
            child: Icon(Icons.add),
          ),
          persistentFooterButtons: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: _reset,
                  child: Text('Reset'),
                  
                ),
              ],
            ),
          ],
        );
    }

 _increament(){
    setState(() {
      _counter++;
    });
 }

 _reset(){
   setState(() {
     _counter = 0;
   });
 }
}