import 'package:bloc/bloc.dart';
import 'package:camera_app/db/database_creation.dart';
import 'package:camera_app/db/database_functions.dart';
import 'package:camera_app/model/image_model.dart';
import 'package:meta/meta.dart';

part 'camera_event.dart';
part 'camera_state.dart';

DataBaseCreation db = DataBaseCreation();
DbFunctions dbFn = DbFunctions();

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  CameraBloc() : super(CameraInitial()) {
    on<ImageAddEvent>((event, emit) async {
      emit(ImageLoadingState());
      try {
        if (await db.isDBExist()) {
          await dbFn.createData(event.imagemodel);
          final values = await dbFn.readData();
          emit(ImageLoadedState(imageList: values));
        }else{
          await db.createDB();
          await dbFn.createData(event.imagemodel);
          final values = await dbFn.readData();
          emit(ImageLoadedState(imageList: values));
        }
      } catch (e) {
        print(e);
        emit(ImageErrorState(error: 'Error Occured'));
      }
    });

    on<ImageLoadEvent>((event, emit) async {
      emit(ImageLoadingState());
      try {
        if (await db.isDBExist()) {
          final List<ImageModel> values = await dbFn.readData();
          emit(ImageLoadedState(imageList: values));
        }else{
          await db.createDB();
          final values = await dbFn.readData();
          emit(ImageLoadedState(imageList: values));
        }
      } catch (e) {
        print('$e loading');
        emit(ImageErrorState(error: 'Error Occured $e'));
      }
    });
  }
}
