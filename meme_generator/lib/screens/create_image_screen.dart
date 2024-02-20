import 'dart:io';
// import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:meme_generator/widgets/create_image_viewmodel.dart';
import 'package:meme_generator/widgets/image_text.dart';
import 'package:screenshot/screenshot.dart';

class CreateImageScreenState extends StatefulWidget {
  final dynamic selectedImage;
  const CreateImageScreenState({super.key, required this.selectedImage});

  @override
  State<CreateImageScreenState> createState() => _CreateImageScreenStateState();
}

class _CreateImageScreenStateState extends CreateImageViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: SizedBox(
          height: 50,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.save,
                  color: Colors.black,
                ),
                onPressed: () => saveToGallery(context),
              ),
              IconButton(
                icon: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                onPressed: increaseFontSize,
                tooltip: 'Increase font size',
              ),
              IconButton(
                icon: const Icon(
                  Icons.remove,
                  color: Colors.black,
                ),
                onPressed: decreaseFontSize,
                tooltip: 'Decrease font size',
              ),
              // IconButton(
              //   icon: const Icon(
              //     Icons.share,
              //     color: Colors.black,
              //   ),
              //   onPressed: () => Share.share(расположение сохраненного файла),
              // ),
            ],
          ),
        ),
      ),
      body: Screenshot(
        controller: screenshotController,
        child: SafeArea(
          child: SizedBox(
            child: Stack(
              children: [
                _selectedImage,
                for (int i = 0; i < texts.length; i++)
                  Positioned(
                    left: texts[i].left,
                    top: texts[i].top,
                    child: GestureDetector(
                      onLongPress: () {
                        setState(() {
                          currentIndex = i;
                          removeText(context);
                        });
                      },
                      onTap: () => setCurrentIndex(context, i),
                      child: Draggable(
                        feedback: ImageText(textInfo: texts[i]),
                        child: ImageText(textInfo: texts[i]),
                        onDragEnd: (drag) {
                          final renderBox =
                              context.findRenderObject() as RenderBox;
                          Offset off = renderBox.globalToLocal(drag.offset);
                          setState(() {
                            texts[i].top = off.dy - 96;
                            texts[i].left = off.dx;
                          });
                        },
                      ),
                    ),
                  ),
                creatorText.text.isNotEmpty
                    ? Positioned(
                        left: 0,
                        bottom: 0,
                        child: Text(
                          creatorText.text,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(
                                0.3,
                              )),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _addText,
    );
  }

  Widget get _addText => FloatingActionButton(
        onPressed: () => addNewDialog(context),
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.edit,
          color: Colors.black,
        ),
      );

  Widget get _selectedImage => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
    //color: Colors.black,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white, width: 2),
    ),
    child: Column(
      children: [
        SizedBox(height: 50),
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Image.file(
                File(widget.selectedImage),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ],
    ),
    ),
  );

}
