import 'package:flutter/material.dart';

void main() {
  runApp(TemperatureConverterApp());
}

class TemperatureConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TemperatureConverter(),
    );
  }
}

class TemperatureConverter extends StatefulWidget {
  @override
  _TemperatureConverterState createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  String conversionType = 'F to C';
  double inputTemperature = 0;
  String result = '';
  List<String> history = [];

  final TextEditingController _controller = TextEditingController();

  void convertTemperature() {
    double convertedTemperature;

    if (conversionType == 'F to C') {
      convertedTemperature = (inputTemperature - 32) * 5 / 9;
    } else {
      convertedTemperature = inputTemperature * 9 / 5 + 32;
    }

    setState(() {
      result = convertedTemperature.toStringAsFixed(2);
      history.add('$conversionType: $inputTemperature => $result');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Temperature Converter',
          style: TextStyle(color: Colors.white), // Set text color to white
        ),
        backgroundColor: Colors.blue[600], // AppBar background color
        centerTitle: true, // Centers the title
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          // This will center the entire content.
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Align children vertically centered.
            children: [
              TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter temperature',
                ),
                onChanged: (value) {
                  setState(() {
                    inputTemperature = double.tryParse(value) ?? 0;
                  });
                },
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .center, // Center the radio buttons horizontally.
                children: [
                  Radio<String>(
                    value: 'F to C',
                    groupValue: conversionType,
                    onChanged: (value) {
                      setState(() {
                        conversionType = value!;
                      });
                    },
                  ),
                  Text('Fahrenheit to Celsius'),
                  Radio<String>(
                    value: 'C to F',
                    groupValue: conversionType,
                    onChanged: (value) {
                      setState(() {
                        conversionType = value!;
                      });
                    },
                  ),
                  Text('Celsius to Fahrenheit'),
                ],
              ),
              ElevatedButton(
                onPressed: convertTemperature,
                child: Text('Convert'),
              ),
              SizedBox(height: 20),
              Text(
                result.isNotEmpty ? 'Converted Value: $result' : '',
                style: TextStyle(fontSize: 18),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: history.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[600], // Background color
                        border: Border.all(
                            color: Colors.grey), // Border color and width
                        borderRadius:
                            BorderRadius.circular(8.0), // Rounded corners
                      ),
                      margin: EdgeInsets.symmetric(
                          vertical: 4.0), // Space between list items
                      child: ListTile(
                        title: Text(
                          history[index],
                          style: TextStyle(
                              color: Colors.white), // Set text color to white
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
