import 'package:flutter/material.dart';

customSnackbar(BuildContext context, String snackbarText) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text('$snackbarText -> not callable yet'),
    backgroundColor: Colors.red,
    elevation: 4,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(5),
    duration: const Duration(seconds: 1),
  ));
}
