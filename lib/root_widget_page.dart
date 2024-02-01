import 'package:camera_app/camera_bloc/camera_bloc.dart';
import 'package:camera_app/screens/picture_capture_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootWidgetPage extends StatelessWidget {
  const RootWidgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CameraBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: PictureCapturePage(),
      ),
    );
  }
}
