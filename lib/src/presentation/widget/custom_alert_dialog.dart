import 'package:flutter/material.dart';
import 'package:hotdeal_with_hono/src/presentation/theme/app_theme.dart';

enum DialogType { success, error, confirmation }

class CustomAlertDialog extends StatelessWidget {
  final DialogType dialogType;
  final String title;
  final String content;

  const CustomAlertDialog({
    super.key,
    required this.dialogType,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.p16),
      ),
      title: Text(title, style: Theme.of(context).textTheme.headlineMedium),
      content: Text(content, style: Theme.of(context).textTheme.bodyLarge),
      actions: <Widget>[
        if (dialogType == DialogType.confirmation)
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        TextButton(
          child: const Text('OK'),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    );
  }
}

// Helper function to show the dialog
Future<bool?> showCustomDialog({
  required BuildContext context,
  required DialogType dialogType,
  required String title,
  required String content,
}) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return CustomAlertDialog(
        dialogType: dialogType,
        title: title,
        content: content,
      );
    },
  );
}
