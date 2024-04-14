import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Meals extends StatefulWidget {
  const Meals({
    super.key,
  });

  @override
  State<Meals> createState() => _MealsState();
}

class _MealsState extends State<Meals> {
  final _controller = TextEditingController();
  final _saiful_controller = TextEditingController();
  final _shakil_controller = TextEditingController();
  final _rizve_controller = TextEditingController();
  final _milton_controller = TextEditingController();
  final _reaz_controller = TextEditingController();

  double pranto = 0.0;
  double saiful = 0.0;
  double shakil = 0.0;
  double rizve = 0.0;
  double milton = 0.0;
  double reaz = 0.0;
  double total = 0.0;

  Map<String, String> dictionary = {};

  DateTime selectedDate = DateTime.now();

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Meals', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue[400],
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey[100],
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Column(
              children: [
                pranto_input(),
                saiful_input(),
                shakil_input(),
                rizve_input(),
                milton_input(),
                reaz_input(),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    date(context),
                    const SizedBox(width: 10.0),
                    reset_button(),
                  ],
                ),
                const SizedBox(height: 20.0),
                submit_button(),
              ],
            )
          ],
        ),
      ),
    );
  }

  ElevatedButton date(BuildContext context) {
    return ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Text('Select date'),
              );
  }

  ElevatedButton reset_button() {
    return ElevatedButton(
                onPressed: () {
                  setState(() {
                    pranto = 0.0;
                    saiful = 0.0;
                    shakil = 0.0;
                    rizve = 0.0;
                    milton = 0.0;
                    reaz = 0.0;
                    total = 0.0;
                    dictionary = {};
                    _controller.text = '';
                    _saiful_controller.text = '';
                    _shakil_controller.text = '';
                    _rizve_controller.text = '';
                    _milton_controller.text = '';
                    _reaz_controller.text = '';
                  });
                },
                child: Text('Reset'),
              );
  }

  ElevatedButton submit_button() {
    return ElevatedButton(
                onPressed: () {

                  setState(() {
                    dictionary = {
                      'Pranto': pranto.toString(),
                      'Saiful': saiful.toString(),
                      'Shakil': shakil.toString(),
                      'Rizve': rizve.toString(),
                      'Milton': milton.toString(),
                      'Reaz': reaz.toString(),
                      'Total':
                          (pranto + saiful + shakil + rizve + milton + reaz)
                              .toString(),
                      'Date': selectedDate.toString(),
                    };
                    print(dictionary);
                  }
                  );
                },
                child: Text('submit'),
              );
  }

  Row reaz_input() {
    return Row(
      children: [
        Text(
          'Reaz',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: _reaz_controller,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                reaz = double.parse(value);
              });
            },
            decoration: InputDecoration(
              labelText: 'Enter a number',
              hintText: 'Hint for the user',
            ),
          ),
        ),
        ButtonBar(
          children: [
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    reaz = reaz - 1;
                    _reaz_controller.text = reaz.toString();
                  });
                },
                child: Text('_')),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  reaz = reaz + 1;
                  _reaz_controller.text = reaz.toString();
                });
              },
              child: Text('+'),
            )
          ],
        ),
      ],
    );
  }

  Row milton_input() {
    return Row(
      children: [
        Text(
          'Milton',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: _milton_controller,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                milton = double.parse(value);
              });
            },
            decoration: InputDecoration(
              labelText: 'Enter a number',
              hintText: 'Hint for the user',
            ),
          ),
        ),
        ButtonBar(
          children: [
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    milton = milton - 1;
                    _milton_controller.text = milton.toString();
                  });
                },
                child: Text('_')),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  milton = milton + 1;
                  _milton_controller.text = milton.toString();
                });
              },
              child: Text('+'),
            )
          ],
        ),
      ],
    );
  }

  Row rizve_input() {
    return Row(
      children: [
        Text(
          'Rizve',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: _rizve_controller,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                rizve = double.parse(value);
              });
            },
            decoration: InputDecoration(
              labelText: 'Enter a number',
              hintText: 'Hint for the user',
            ),
          ),
        ),
        ButtonBar(
          children: [
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    rizve = rizve - 1;
                    _rizve_controller.text = rizve.toString();
                  });
                },
                child: Text('_')),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  rizve = rizve + 1;
                  _rizve_controller.text = rizve.toString();
                });
              },
              child: Text('+'),
            )
          ],
        ),
      ],
    );
  }

  Row shakil_input() {
    return Row(
      children: [
        Text(
          'Shakil',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: _shakil_controller,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                shakil = double.parse(value);
              });
            },
            decoration: InputDecoration(
              labelText: 'Enter a number',
              hintText: 'Hint for the user',
            ),
          ),
        ),
        ButtonBar(
          children: [
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    shakil = shakil - 1;
                    _shakil_controller.text = shakil.toString();
                  });
                },
                child: Text('_')),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  shakil = shakil + 1;
                  _shakil_controller.text = shakil.toString();
                });
              },
              child: Text('+'),
            )
          ],
        ),
      ],
    );
  }

  Row saiful_input() {
    return Row(
      children: [
        Text(
          'saiful',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: _saiful_controller,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                saiful = double.parse(value);
              });
            },
            decoration: InputDecoration(
              labelText: 'Enter a number',
              hintText: 'Hint for the user',
            ),
          ),
        ),
        ButtonBar(
          children: [
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    saiful = saiful - 1;
                    _saiful_controller.text = saiful.toString();
                  });
                },
                child: const Text('_')),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  saiful = saiful + 1;
                  _saiful_controller.text = saiful.toString();
                });
              },
              child: Text('+'),
            )
          ],
        ),
      ],
    );
  }

  Row pranto_input() {
    return Row(
      children: [
        Text(
          'Pranto',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                pranto = double.parse(value);
              });
            },
            decoration: const InputDecoration(
              labelText: 'Enter a number',
              hintText: 'Hint for the user',
            ),
          ),
        ),
        ButtonBar(
          children: [
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    pranto = pranto - 1;
                    _controller.text = pranto.toString();
                  });
                },
                child: Text('_')),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  pranto = pranto + 1;
                  _controller.text = pranto.toString();
                });
              },
              child: Text('+'),
            )
          ],
        ),
      ],
    );
  }
}
