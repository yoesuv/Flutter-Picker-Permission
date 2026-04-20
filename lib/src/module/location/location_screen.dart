import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/src/module/location/location_bloc.dart';
import 'package:flutter_picker/src/module/location/location_event.dart';
import 'package:flutter_picker/src/module/location/location_state.dart';
import 'package:flutter_picker/src/utils/app_util.dart';
import 'package:flutter_picker/src/widgets/dialog_open_app_settings.dart';
import 'package:flutter_picker/src/widgets/my_button.dart';
import 'package:permission_handler/permission_handler.dart';

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
      appBar: AppBar(title: const Text('Location')),
      body: BlocListener<LocationBloc, LocationState>(
        bloc: _bloc,
        listenWhen: (previous, current) =>
            previous.permissionStatus != current.permissionStatus ||
            previous.locationService != current.locationService ||
            previous.errorMessage != current.errorMessage,
        listener: (context, state) {
          if (state.errorMessage != null) {
            showErrorSnackBar(context, state.errorMessage!);
            return;
          }

          if (state.permissionStatus != null) {
            if (state.permissionStatus != PermissionStatus.granted) {
              showErrorSnackBar(
                context,
                'Permission ${state.permissionStatus?.name}',
              );
            }
            showDialog(
              context: context,
              builder: (context) {
                return const DialogOpenAppSettings();
              },
            );
          }
          if (state.locationService == false) {
            showErrorSnackBar(context, 'Location Service is Disabled');
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextLocation(),
                const SizedBox(height: 16),
                _buildButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextLocation() {
    return BlocBuilder<LocationBloc, LocationState>(
      bloc: _bloc,
      buildWhen: (previous, current) => previous.strLatLng != current.strLatLng,
      builder: (context, state) {
        return Text(
          state.strLatLng ?? '',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        );
      },
    );
  }

  Widget _buildButton() {
    return Center(
      child: BlocBuilder<LocationBloc, LocationState>(
        bloc: _bloc,
        buildWhen: (previous, current) =>
            previous.isLoading != current.isLoading,
        builder: (context, state) {
          return MyButton(
            title: 'GET LOCATION',
            isLoading: state.isLoading,
            onPressed: () {
              if (!state.isLoading) {
                _bloc.add(GetLocationEvent());
              }
            },
          );
        },
      ),
    );
  }
}
