import 'package:custom_button_with_slider/custom_button.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var returnValue = '';

  dynamic _shoeReturnValue(val) {
    print('Return Value is: $val');
    setState(() {
      val ? returnValue = 'Initial State' : returnValue = 'Changed State';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                onTapFun: _shoeReturnValue,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Button is in '${returnValue.toString()}'",
                style: TextStyle(fontSize: 30.0, color: Colors.deepOrange),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
