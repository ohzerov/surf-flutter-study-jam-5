import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:meme_generator/widgets/cap_editor_widget.dart';

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class CapScreen extends StatefulWidget {
  const CapScreen({super.key});

  @override
  State<CapScreen> createState() => _CapScreenState();
}

class _CapScreenState extends State<CapScreen> {
  final GlobalKey globalKey = GlobalKey();

  void _saveToGallery() async {
    final RenderRepaintBoundary boundary =
        globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    final ui.Image image = await boundary.toImage();
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();
    await ImageGallerySaver.saveImage(pngBytes);
  }

  void _shareImage() async {
    final RenderRepaintBoundary boundary =
        globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    final ui.Image image = await boundary.toImage();
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();

    final tempDir = await getTemporaryDirectory();
    final tempPath = tempDir.path;
    final imageFile = await File('$tempPath/image.png').writeAsBytes(pngBytes);

    // Поделиться изображением с другими приложениями
    await Share.shareXFiles([XFile(imageFile.path)], text: 'Sharing image');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Создай свой мем")),
        //loatingActionButton:
        backgroundColor: Colors.black,
        body: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            RepaintBoundary(
              key: globalKey,
              child: const CapEditorWidget(),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, bottom: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    onPressed: _shareImage,
                    child: const Icon(Icons.share_outlined),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  FloatingActionButton(
                    onPressed: _saveToGallery,
                    child: const Icon(Icons.save_outlined),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
