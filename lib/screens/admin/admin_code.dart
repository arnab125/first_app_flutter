import 'package:first_project/screens/admin/get_code.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Admin extends StatefulWidget {
  const Admin({
    super.key
    });

  @override
  State<Admin> createState() => _AdminState();
}
  
class _AdminState extends State<Admin> {
  final codeController = TextEditingController();

  @override
  void dispose() {
    codeController.dispose();
    
    super.dispose();
  }
    @override
    Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('ListView Example', style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: Colors.blue[400],
            centerTitle: true,
          ),
          body: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Text('Enter Code to have access to Admin features', style: TextStyle(fontSize: 20)),
                SizedBox(height: 20),
                TextField(
                  controller: codeController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.blue[100],
            
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Enter Code',
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green[500]),
                  ),
                  onPressed: () async {
                    if (codeController.text.isEmpty) {
                      return;
                    }
                    await saveSecretCode(codeController.text);
                    setState(() {
                      
                    });
                  },
                  child: Text('Submit', style: TextStyle(color: Colors.white)),
                ),
                SizedBox(height: 20),
                FutureBuilder<String>(
              future: getSecretCode(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else {
                  return Text("Your code is: ${snapshot.data ?? 'Not set'}");
                }
              },
            ),
              ],
            ),
          ),
        );
    }
     Future<void> saveSecretCode(String code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('secret_code', code);
  }
}