import 'package:image_picker/image_picker.dart';

class ImageAdapter extends XFile {
  ImageAdapter(super.path);

  static Future<ImageAdapter?> fetchImageFromGallery() async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      return ImageAdapter(file.path);
    } else {
      return null;
    }
  }
}
