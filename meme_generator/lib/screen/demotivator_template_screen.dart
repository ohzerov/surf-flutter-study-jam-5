import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:meme_generator/widgets/demotivator_editor_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class DemotivatorScreen extends StatefulWidget {
  const DemotivatorScreen({super.key});

  @override
  State<DemotivatorScreen> createState() => _DemotivatorScreenState();
}

class _DemotivatorScreenState extends State<DemotivatorScreen> {
  final GlobalKey globalKey = GlobalKey();

  void _saveToGallery() async {
    final RenderRepaintBoundary boundary =
        globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    final ui.Image image = await boundary.toImage();
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();
    await ImageGallerySaver.saveImage(pngBytes);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Сохранено в галерею")));
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
        appBar: AppBar(title: const Text("Демотиватор")),
        //loatingActionButton:
        backgroundColor: Colors.black,
        body: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            const Positioned(
              top: 30,
              left: 20,
              right: 20,
              child: Text(
                "Чтобы заменить изображение - нажми на него",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            RepaintBoundary(
              key: globalKey,
              child: const DemotivatorEditorWidget(),
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
