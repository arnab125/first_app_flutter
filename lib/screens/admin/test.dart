import 'package:first_project/screens/admin/drawer.dart';
import 'package:first_project/screens/admin/get_code.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import http package
import 'dart:convert'; // Import dart:convert to use jsonEncode()



class Khabar extends StatefulWidget {
  const Khabar({
    super.key,
  });

  @override
  State<Khabar> createState() => _KhabarState();
}

class _KhabarState extends State<Khabar> {
  final prantoController = TextEditingController(text: '0.0');
  final saifulController = TextEditingController(text: '0.0');
  final shakilController = TextEditingController(text: '0.0');
  final miltonController = TextEditingController(text: '0.0');
  final reazController = TextEditingController(text: '0.0');
  final rizveController = TextEditingController(text: '0.0');

  DateTime selectedDate = DateTime.now();
  bool isLoading = false;


Future<Map<String, dynamic>> sendData() async {
  try {
    String? code = await getSecretCode();
    var url = Uri.parse('https://advanced-teddie-pranto.koyeb.app/add_meals?code=$code');

    // Define data as a Map
    var data = {
      "pranto": double.parse(prantoController.text),
      "saiful": double.parse(saifulController.text),
      "shakil": double.parse(shakilController.text),
      "milton": double.parse(miltonController.text),
      "rizve": double.parse(rizveController.text),
      "reaz": double.parse(reazController.text),
      "date": {
        "day": selectedDate.day,
        "month": selectedDate.month,
        "year": selectedDate.year
      }
    };

    // Convert data to JSON format
    var jsonData = jsonEncode(data);

    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'}, // Set content type to JSON
      body: jsonData, // Send JSON data in the request body
    );

    if (response.statusCode == 200) {

      Map<String, dynamic> responseBody = jsonDecode(response.body);
      return responseBody;
    } else {
      // Return null or throw an error if desired
      
      return {'message': 'Error sending data'};
    }
  } catch (error) {
    
    print('Error sending data: $error');
    // Return null or throw an error if desired
    return {'message': 'Error sending data'};
  }
}


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  void dispose() {
    prantoController.dispose();
    saifulController.dispose();
    shakilController.dispose();
    miltonController.dispose();
    reazController.dispose();
    rizveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Meals', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),), 
        backgroundColor: Colors.green[600],
      ),
      drawer: drawer(context),
      body: isLoading?Center(child: CircularProgressIndicator()):Container(
        color: Colors.blue[100],
        child: Form(
          
          child: ListView(
            padding: const EdgeInsets.all(14.0),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: prantoController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Pranto',
                    hintText: 'Enter Pranto',
                  ),
                ),
              ),
              Row(
                children: [
                  ButtonBar(
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[500],
                          ),
                          onPressed: () {
                            setState(() {
                              if (double.parse(prantoController.text) > 0){
                                prantoController.text =
                                  (double.parse(prantoController.text) - 1)
                                      .toString();
                              }
                            });
                          },
                          child: Text('_', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[500],
                        ),
                        onPressed: () {
                          setState(() {
                            if (double.parse(prantoController.text) >= 0){
                            prantoController.text =
                                (double.parse(prantoController.text) + 1)
                                    .toString();
                          }
                          });
                        },
                        child: Text('+' , style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      )
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                   keyboardType: TextInputType.number,
                  controller: saifulController,
                  decoration: InputDecoration(
                    filled: true,
                     fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Saiful',
                    hintText: 'Enter Saiful',
                  ),
                ),
              ),
              Row(
                children: [
                  ButtonBar(
                    children: [
                      ElevatedButton(
                         style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[500],
                          ),
                          onPressed: () {
                            setState(
                              () {
                                if (double.parse(saifulController.text) > 0){
                                  saifulController.text =
                                    (double.parse(saifulController.text) - 1)
                                        .toString();
                                }
                              },
                            );
                          },
                          child: Text('_', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
                      ElevatedButton(
                         style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[500],
                        ),
                        onPressed: () {
                          setState(() {
                            if (double.parse(saifulController.text) >= 0){
                            saifulController.text =
                                (double.parse(saifulController.text) + 1)
                                    .toString();
                          }
                          });
                        },
                        child: Text('+', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      )
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: shakilController,
                  decoration: InputDecoration(
                    filled: true,
                     fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Shakil',
                    hintText: 'Enter Shakil',
                  ),
                ),
              ),
              Row(
                children: [
                  ButtonBar(
                    children: [
                      ElevatedButton(
                         style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[500],
                          ),
                          onPressed: () {
                            setState(
                              () {
                                if (double.parse(shakilController.text) > 0){
                                  shakilController.text =
                                    (double.parse(shakilController.text) - 1)
                                        .toString();
                                }
                              },
                            );
                          },
                          child: Text('_', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)), 
                      ElevatedButton(
                         style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[500],
                        ),
                        onPressed: () {
                          setState(() {
                            if (double.parse(shakilController.text) >= 0){
                            shakilController.text =
                                (double.parse(shakilController.text) + 1)
                                    .toString();
                          }
                          });
                        },
                        child: Text('+', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      )
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                   keyboardType: TextInputType.number,
                  controller: miltonController,
                  decoration: InputDecoration(
                    filled: true,
                     fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Milton',
                    hintText: 'Enter Milton',
                  ),
                ),
              ),
              Row(
                children: [
                  ButtonBar(
                    children: [
                      ElevatedButton(
                         style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[500],
                          ),
                          onPressed: () {
                            setState(
                              () {
                                if (double.parse(miltonController.text) > 0){
                                  miltonController.text =
                                    (double.parse(miltonController.text) - 1)
                                        .toString();
                                }
                              },
                            );
                          },
                          child: Text('_', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
                      ElevatedButton(
                         style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[500],
                        ),
                        onPressed: () {
                          setState(
                            () {
                              if (double.parse(miltonController.text) >= 0){
                                miltonController.text =
                                  (double.parse(miltonController.text) + 1)
                                      .toString();
                              }
                            },
                          );
                        },
                        child: Text('+', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      )
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                   keyboardType: TextInputType.number,
                  controller: reazController,
                  decoration: InputDecoration(
                     filled: true,
                     fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Reaz',
                    hintText: 'Enter Reaz',
                  ),
                ),
              ),
              Row(
                children: [
                  ButtonBar(
                    children: [
                      ElevatedButton(
                         style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[500],
                          ),
                          onPressed: () {
                            setState(
                              () {
                                if (double.parse(reazController.text) > 0){
                                  reazController.text =
                                    (double.parse(reazController.text) - 1)
                                        .toString();
                                }
                              },
                            );
                          },
                          child: Text('_', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
                      ElevatedButton(
                         style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[500],
                        ),
                        onPressed: () {
                          setState(
                            () {
                              if (double.parse(reazController.text) >= 0){
                                reazController.text =
                                  (double.parse(reazController.text) + 1)
                                      .toString();
                              }
                            },
                          );
                        },
                        child: Text('+', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      )
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                   keyboardType: TextInputType.number,
                  controller: rizveController,
                  decoration: InputDecoration(
                      filled: true,
                     fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Rizve',
                    hintText: 'Enter Rizve',
                  ),
                ),
              ),
              Row(
                children: [
                  ButtonBar(
                    children: [
                      ElevatedButton(
                         style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[500],
                          ),
                          onPressed: () {
                            setState(
                              () {
                                if (double.parse(rizveController.text) > 0){
                                  rizveController.text =
                                    (double.parse(rizveController.text) - 1)
                                        .toString();
                                }
                              },
                            );
                          },
                          child: Text('_', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[500],
                        ),
                        
                        onPressed: () {
                          setState(
                            () {
                              if (double.parse(rizveController.text) >= 0){
                                rizveController.text =
                                  (double.parse(rizveController.text) + 1)
                                      .toString();
                              }
                            },
                          );
                        },
                        child: Text('+', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[500],
                      ),
                      onPressed: () => _selectDate(context),
                      child: Row(
                        children: [
                          Text('Select date ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
                          Icon(Icons.calendar_today, color: Colors.white, size: 16,),
                        ],
                      )
                      
                    ),
                  SizedBox(width: 20),
                  ElevatedButton(onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    var responseBody = await sendData(); // Wait for sendData function to complete
                    String message = responseBody['message'];
                   bool success = responseBody['success'] ?? false;
                    setState(() {
                      isLoading = false;
                    });
                    showDefaultValuesPopup(context, message, success);
                                    },
                    
                  child: Row(
                    children: [
                      Text('Submit ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                      Icon(Icons.check, color: Colors.white, size: 16,)
                    ],
                  ),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[400]),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      
    );

  }
  
  void showDefaultValuesPopup(BuildContext context, String message, bool success) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Meals for ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'),
        content: SingleChildScrollView(
          child: (success??false)?ListBody(
            children: <Widget>[
              Text('Pranto: ${prantoController.text}'),
              Text('Saiful: ${saifulController.text}'),
              Text('Shakil: ${shakilController.text}'),
              Text('Milton: ${miltonController.text}'),
              Text('Reaz: ${reazController.text}'),
              Text('Rizve: ${rizveController.text}'),
              Row(
                children: [
                  Text(message, style: TextStyle(color: Colors.green[600], fontWeight: FontWeight.bold),),
                  Icon(Icons.check, color: Colors.green[600], size: 16,)
                ],
              )
            ],
          ):
          ListBody(
            children: <Widget>[
              Row(
                children: [
                  Text(message, style: TextStyle(color: Colors.red[600], fontWeight: FontWeight.bold),),
                  Icon(Icons.error, color: Colors.red[600], size: 16,)
                ],
              )
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

  
}
