part of 'camera_bloc.dart';

@immutable
sealed class CameraState {}

class CameraInitial extends CameraState {}


class ImageLoadingState extends CameraState {}

class ImageLoadedState extends CameraState {
  final List<ImageModel> imageList;
  ImageLoadedState({
    required this.imageList,
  });
}

class ImageErrorState extends CameraState {
  final String error;
  ImageErrorState({
    required this.error,
  });
}
