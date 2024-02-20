import 'package:meme_generator/models/meme_template_model.dart';

import 'package:meme_generator/screen/demotivator_template_screen.dart';

final templates = [
  MemeTemplateModel(
      title: "Демотиватор",
      previewImgUrl:
          "https://avatars.dzeninfra.ru/get-zen_doc/2480061/pub_5f33dbc5cc6f436f1530d22a_5f37121ed5746719329c99dc/scale_1200",
      widgetRoute: DemotivatorScreen()),
  MemeTemplateModel(
      title: 'Кэп',
      previewImgUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPJ66creWQO9VbqUBZzfgha2nZsPxaxPdyrQ&usqp=CAU',
      widgetRoute: DemotivatorScreen()),
];
