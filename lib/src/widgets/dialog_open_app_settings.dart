import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/src/widgets/my_button.dart';

class DialogOpenAppSettings extends StatelessWidget {
  const DialogOpenAppSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Open App Settings to allow permission',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              MyButton(title: 'OPEN', onPressed: () {
                AppSettings.openAppSettings();
              }),
            ],
          ),
        ),
      ),
    );
  }

}