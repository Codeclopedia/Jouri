import 'package:Jouri/components/loading.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  LoadingOverlay({required this.isLoading,required this.child});

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: child,
      progressIndicator: Loading(),
      opacity: 0.6,
      color: Colors.white,
      dismissible: false,
    );
  }

}
