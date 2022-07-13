import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/src/module/gallery/bloc/take_gallery_bloc.dart';
import 'package:flutter_picker/src/module/gallery/event/take_gallery_event.dart';
import 'package:flutter_picker/src/module/gallery/state/take_gallery_state.dart';
import 'package:flutter_picker/src/widgets/my_button.dart';

class TakeGalleryScreen extends StatefulWidget {
  static const routeName = 'take_gallery';
  const TakeGalleryScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TakeGalleryScreenState();
  }
}

class _TakeGalleryScreenState extends State<TakeGalleryScreen> {
  late TakeGalleryBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<TakeGalleryBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take Gallery'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImage(),
              const SizedBox(height: 16),
              _buildTextPath(),
              const SizedBox(height: 16),
              _buildButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return BlocBuilder<TakeGalleryBloc, TakeGalleryState>(
      builder: (context, state) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 200,
          child: state.file != null
              ? Image.file(
                  state.file!,
                  fit: BoxFit.cover,
                )
              : Container(),
        );
      },
    );
  }

  Widget _buildTextPath() {
    return BlocBuilder<TakeGalleryBloc, TakeGalleryState>(
      buildWhen: (previous, current) => previous.path != current.path,
      builder: (context, state) {
        return Text('${state.path}');
      },
    );
  }

  Widget _buildButton() {
    return Center(
      child: MyButton(
        title: 'OPEN GALLERY',
        onPressed: () {
          _bloc.add(TakeGalleryOpenEvent());
        },
      ),
    );
  }
}
