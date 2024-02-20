import 'package:flutter/material.dart';

import '../data/dummy_templates.dart';

class TemplatesScreen extends StatelessWidget {
  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Выбери шаблон")),
      body: ListView.builder(
          itemCount: templates.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => templates[index].widgetRoute,
                  ),
                );
              },
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: Column(
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        child: Image.network(
                          templates[index].previewImgUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        templates[index].title,
                        style: TextStyle(fontSize: 22),
                      ),
                      const Divider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
