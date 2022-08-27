import 'package:flutter/material.dart';

class ConfirmDailog extends StatelessWidget {
  final Function(bool) onConfirm;
  const ConfirmDailog({Key? key, required this.onConfirm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
          return AlertDialog(
            title: const Text('Please Confirm'),
            content: const Text('Are you sure you want to do this?'),
            actions: [
              // The "Yes" button
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    onConfirm(true);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Yes')),
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    onConfirm(false);
                     Navigator.of(context).pop();
                  },
                  child: const Text('No'))
            ],
          );
        
  }
}
