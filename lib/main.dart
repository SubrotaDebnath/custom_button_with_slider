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

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  dynamic _shoeReturnValue(val) {
    print('Return Value is: $val');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: CustomButton(
            onTapFun: _shoeReturnValue,
          ),
        ),
      ),
    );
  }
}
