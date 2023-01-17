import 'package:flutter/material.dart';
import 'package:flutter_picker/src/widgets/my_button.dart';

class LocationScreen extends StatelessWidget {
  static const routeName = 'get_location';
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('7.538292, 114.9857694'),
              SizedBox(height: 16),
              _buildButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton() {
    return Center(
      child: MyButton(
        title: 'GET LOCATION',
        onPressed: () {},
      ),
    );
  }
}
