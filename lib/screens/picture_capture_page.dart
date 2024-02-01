import 'dart:io';
import 'package:camera_app/camera_bloc/camera_bloc.dart';
import 'package:camera_app/model/image_model.dart';
import 'package:camera_app/screens/imageshowing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class PictureCapturePage extends StatefulWidget {
  PictureCapturePage({super.key});
  @override
  State<PictureCapturePage> createState() => _PictureCapturePageState();
}

class _PictureCapturePageState extends State<PictureCapturePage> {
  File? capturedImage;

  static const kHeight = SizedBox(height: 10);
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CameraBloc>(context).add(ImageLoadEvent());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Camera",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: BlocBuilder<CameraBloc, CameraState>(
        builder: (context, state) {
          if (state is ImageLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ImageLoadedState) {
            return SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      kHeight,
                      const Text(
                        "Take A Photo",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      kHeight,
                      GestureDetector(
                        onTap: () async {
                          final pickedImage = await ImagePicker()
                              .pickImage(source: ImageSource.camera);
                          if (pickedImage != null) {
                            setState(() {
                              capturedImage = File(pickedImage.path);
                            });
                            final imagemodel =
                                ImageModel(imagepath: capturedImage?.path);
                            BlocProvider.of<CameraBloc>(context)
                                .add(ImageAddEvent(imagemodel: imagemodel));
                          }
                        },
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          size: 50,
                        ),
                      ),
                      kHeight,
                      Expanded(
                        child: GridView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          itemCount: state.imageList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10),
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ImageShowingPage(
                                    capturedImage:
                                        state.imageList[index].imagepath!),
                              ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color.fromARGB(114, 199, 199, 199),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(
                                      File(state.imageList[index].imagepath!)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else if (state is ImageErrorState) {
            return Center(
              child: Text(state.error),
            );
          }
          return const SizedBox(
            child: Text("data"),
          );
        },
      ),
    );
  }
}
