import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/src/module/location/bloc/location_bloc.dart';
import 'package:flutter_picker/src/widgets/my_button.dart';

class LocationScreen extends StatefulWidget {
  static const routeName = 'get_location';

  const LocationScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LocationScreenState();
  }

}

class _LocationScreenState extends State<LocationScreen> {

  late LocationBloc _bloc;
  
  @override
  void initState() {
    super.initState();
    _bloc = context.read<LocationBloc>();
  }

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
