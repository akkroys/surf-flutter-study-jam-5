import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meme_generator/screens/create_image_screen.dart';
import 'package:meme_generator/utilities/custom_button.dart';
import 'package:meme_generator/utilities/enter_link_dialog.dart';

class GeneratingMenu extends StatefulWidget {
  const GeneratingMenu({super.key});

  @override
  State<GeneratingMenu> createState() => _GeneratingMenuState();
}

class _GeneratingMenuState extends State<GeneratingMenu> {
  final _textController = TextEditingController();
  String _url = '';

  void enterLink() {
    setState(() {
      _url = _textController.text;
      _textController.clear();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CreateImageScreenState(selectedImage: _url)));
    });
    Navigator.of(context).pop();
  }

  void cancelDialog() {
    setState(() {
      _textController.clear();
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      appBar: AppBar(
        title: const Text(
          'Конструктор мемов',
        ),
        elevation: 0,
        backgroundColor: Colors.grey[200],
      ),
      body: Center(
        child: Column(
          children: [
            CustomButton(
              data: CustomButtonData(
                Icons.photo,
                'Изображение из галереи',
              ),
              onPressed: () async {
                XFile? file = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                );
                if (file != null) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          CreateImageScreenState(selectedImage: file.path),
                    ),
                  );
                }
              },
            ),
            CustomButton(
              data: CustomButtonData(
                Icons.camera_alt,
                'Фото с камеры',
              ),
              onPressed: () async {
                XFile? file = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                );
                if (file != null) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          CreateImageScreenState(selectedImage: file.path),
                    ),
                  );
                }
              },
            ),
            // CustomButton(
            //   data: CustomButtonData(
            //     Icons.link,
            //     'Фото по ссылке',
            //   ),
            //   onPressed: () {
            //     showDialog(
            //       context: context,
            //       builder: (BuildContext context) {
            //         return EnterLinkDialogBox(
            //           controller: _textController,
            //           onAdd: enterLink,
            //           onCancel: cancelDialog,
            //         );
            //       },
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
