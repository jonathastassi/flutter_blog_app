import 'package:flutter/material.dart';

class OutlinedButtonCustom extends OutlinedButton {
  const OutlinedButtonCustom({
    Key? key,
    required Widget child,
    required VoidCallback? onPressed,
    bool loading = false,
  }) : super(
          key: key,
          child: loading
              ? const SizedBox(
                  child: CircularProgressIndicator(),
                  height: 25,
                  width: 25,
                )
              : child,
          onPressed: loading ? null : onPressed,
        );
}
