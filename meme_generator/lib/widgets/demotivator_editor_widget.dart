import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DemotivatorEditorWidget extends StatefulWidget {
  const DemotivatorEditorWidget({super.key});

  State<DemotivatorEditorWidget> createState() => _DemotivatorWidgetState();
}

class _DemotivatorWidgetState extends State<DemotivatorEditorWidget> {
  GlobalKey textKey = GlobalKey();

  bool isUrl =
      true; // Если true, показывается изображение из url, если false, то из галереи
  String imgUrl = 'https://i.redd.it/0oaxe7asyw461.jpg';
  final setLinkTextController = TextEditingController();
  File? galleryImage;

  void pickImage() {
    showBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            width: double.infinity,
            height: 300,
            child: Column(children: [
              const SizedBox(
                height: 24,
              ),
              const Text('Выберите тип изображения'),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: setLink,
                    child: const Text("Вставить ссылку"),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                    onPressed: setFromGallery,
                    child: const Text("Выбрать из галереи"),
                  ),
                ],
              )
            ]),
          );
        });
  }

  void setLink() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              width: 200,
              height: 200,
              child: Column(
                children: [
                  const Text("Вставьте ссылку"),
                  TextField(
                    decoration:
                        const InputDecoration(hintText: "Вставьте ссылку"),
                    controller: setLinkTextController,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (setLinkTextController.text.isNotEmpty) {
                          imgUrl = setLinkTextController.text;
                          isUrl = true;
                        }
                      });
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.check_circle_outline_sharp,
                      size: 35,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void setFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      galleryImage = File(returnedImage!.path);
      isUrl = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      border: Border.all(
        color: Colors.white,
        width: 2,
      ),
    );
    return Center(
      child: ColoredBox(
        color: const Color.fromARGB(255, 0, 0, 0),
        child: DecoratedBox(
          decoration: decoration,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 50,
              vertical: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: pickImage,
                  child: SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: DecoratedBox(
                      decoration: decoration,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: isUrl
                            ? Image.network(
                                imgUrl,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                galleryImage!,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                ),
                TextField(
                  textAlign: TextAlign.center,
                  enableInteractiveSelection: false,
                  showCursor: true,
                  cursorColor: Color.fromARGB(37, 255, 255, 255),
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  maxLength: 80,
                  controller: TextEditingController(
                      text: "Нажми на текст, чтобы изменить"),
                  decoration: const InputDecoration(
                      border: InputBorder.none, counterText: ""),
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
