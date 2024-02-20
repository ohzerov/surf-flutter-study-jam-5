import 'package:flutter/material.dart';

class CapEditorWidget extends StatefulWidget {
  const CapEditorWidget({super.key});

  State<CapEditorWidget> createState() => _MemeEditorWidgetState();
}

class _MemeEditorWidgetState extends State<CapEditorWidget> {
  bool isUrl =
      true; // Если true, показывается изображение из url, если false, то из галереи
  String imgUrl =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwPOCy5KYdVzH4pT_EKERSrTW5tNIPmx4-ffsJVJZSDJgVdIgXPdhCMBbnQaq8Y6nAfg&usqp=CAU';
  final setLinkTextController = TextEditingController();

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
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: DecoratedBox(
                    decoration: decoration,
                    child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Image.network(
                          imgUrl,
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
                TextField(
                  textAlign: TextAlign.center,
                  enableInteractiveSelection: false,
                  showCursor: false,
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
