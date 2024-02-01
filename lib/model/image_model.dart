
class ImageModel {
  final int? id;
  final String? imagepath;
  ImageModel({
    this.id,
    this.imagepath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imagepath': imagepath,
    };
  }

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      id: map['id'],
      imagepath: map['imagepath'],
    );
  }
}
