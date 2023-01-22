import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/src/module/file/bloc/take_file_bloc.dart';
import 'package:flutter_picker/src/module/file/event/take_file_event.dart';
import 'package:flutter_picker/src/module/file/state/take_file_state.dart';
import 'package:flutter_picker/src/utils/app_util.dart';
import 'package:flutter_picker/src/widgets/my_button.dart';
import 'package:permission_handler/permission_handler.dart';

class TakeFileScreen extends StatefulWidget {
  static const routeName = 'take_file';
  const TakeFileScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TakeFileScreenState();
  }
}

class _TakeFileScreenState extends State<TakeFileScreen> {
  late TakeFileBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<TakeFileBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take File'),
      ),
      body: BlocListener<TakeFileBloc, TakeFileState>(
        bloc: _bloc,
        listenWhen: (previous, current) =>
        previous.permissionStatus != current.permissionStatus,
        listener: (context, state) {
          if (state.permissionStatus != null) {
            if (state.permissionStatus != PermissionStatus.granted) {
              showErrorSnackBar(
                context,
                'Permission ${state.permissionStatus?.name}',
              );
            }
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextPath(),
                const SizedBox(height: 16),
                _buildButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextPath() {
    return BlocBuilder<TakeFileBloc, TakeFileState>(
      builder: (context, state) {
        return Text('${state.path}');
      },
    );
  }

  Widget _buildButton() {
    return Center(
      child: MyButton(
        title: 'OPEN FILE',
        onPressed: () {
          _bloc.add(TakeFileChooseEvent());
        },
      ),
    );
  }
}
