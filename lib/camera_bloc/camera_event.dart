part of 'camera_bloc.dart';

@immutable
abstract class CameraEvent {}

class ImageAddEvent extends CameraEvent {
  final ImageModel imagemodel;
  ImageAddEvent({
    required this.imagemodel,
  });
}

class ImageLoadEvent extends CameraEvent{}
