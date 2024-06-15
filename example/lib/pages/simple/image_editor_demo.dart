import 'package:example/common/image_picker/image_picker.dart';
import 'package:example/common/utils/crop_editor_helper.dart';
import 'package:extended_image/extended_image.dart';
import 'package:ff_annotation_route_core/ff_annotation_route_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

@FFRoute(
  name: 'fluttercandies://simpleimageeditor',
  routeName: 'ImageEditor',
  description: 'Crop with image editor.',
  exts: <String, dynamic>{
    'group': 'Simple',
    'order': 6,
  },
)









// Container(width: 300,height: 600,child: DxUploadAvatarSelector(),)
class SimpleImageEditor extends StatefulWidget {
  @override
  _SimpleImageEditorState createState() => _SimpleImageEditorState();
}

class _SimpleImageEditorState extends State<SimpleImageEditor> {
  final GlobalKey<ExtendedImageEditorState> editorKey =
      GlobalKey<ExtendedImageEditorState>();
  bool _cropping = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ImageEditor'),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.crop),
          onPressed: () {
            cropImage();
          }),
    );
  }

  Future<void> cropImage() async {
    if (_cropping) {
      return;
    }
    _cropping = true;
    try {
      final EditImageInfo fileData = kIsWeb
          ? (await cropImageDataWithDartLibrary(state: editorKey.currentState!))
          : (await cropImageDataWithNativeLibrary(
              state: editorKey.currentState!));
      final String? fileFath = await ImageSaver.save(
          'extended_image_cropped_image.jpg', fileData.data!);
      showToast('save image : $fileFath');
    } finally {
      _cropping = false;
    }
  }

}
