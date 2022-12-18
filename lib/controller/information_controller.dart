import 'package:web_slider/model/information_model.dart';

class InformationController {
  final data = [
    InformationModel(
      'A color scheme is a combination of colors that create a harmonious and appealing visual effect.',
      sourceUrl,
      [
        ListOfImages(
          imageUrl: image1,
          source: sourceUrl,
        ),
        ListOfImages(
          imageUrl: image2,
          source: sourceUrl,
        ),
        ListOfImages(
          imageUrl: image3,
          source: sourceUrl,
        ),
      ],
    ),
    InformationModel(
      'Color schemes can be used for various purposes, such as web design, interior design, art, fashion, and branding.',
      sourceUrl,
      [
        ListOfImages(
          imageUrl: image2,
          source: sourceUrl,
        ),
        ListOfImages(
          imageUrl: image3,
          source: sourceUrl,
        ),
        ListOfImages(
          imageUrl: image1,
          source: sourceUrl,
        ),
      ],
    ),
    InformationModel(
      'SchemeColor.com is a website that offers thousands of ready-made and custom color schemes that can be downloaded, created, and shared online.',
      sourceUrl,
      [
        ListOfImages(
          imageUrl: image3,
          source: sourceUrl,
        ),
        ListOfImages(
          imageUrl: image1,
          source: sourceUrl,
        ),
        ListOfImages(
          imageUrl: image2,
          source: sourceUrl,
        ),
      ],
    ),
    InformationModel(
      'The website allows users to browse color schemes by categories, such as red, orange, pink, purple, blue, green, yellow, violet, and gray.',
      sourceUrl,
      [
        ListOfImages(
          imageUrl: image1,
          source: sourceUrl,
        ),
        ListOfImages(
          imageUrl: image2,
          source: sourceUrl,
        ),
        ListOfImages(
          imageUrl: image3,
          source: sourceUrl,
        ),
      ],
    ),
    InformationModel(
      'Users can also search for color schemes by keywords, such as valentine, wedding, exterior painting, or color scheme from images.',
      sourceUrl,
      [
        ListOfImages(
          imageUrl: image2,
          source: sourceUrl,
        ),
        ListOfImages(
          imageUrl: image3,
          source: sourceUrl,
        ),
        ListOfImages(
          imageUrl: image1,
          source: sourceUrl,
        ),
      ],
    ),
    InformationModel(
      'SchemeColor.com also provides detailed information on hexadecimal, RGB, and CMYK color codes, as well as color theory, tips, and trends.',
      sourceUrl,
      [
        ListOfImages(
          imageUrl: image3,
          source: sourceUrl,
        ),
        ListOfImages(
          imageUrl: image1,
          source: sourceUrl,
        ),
        ListOfImages(
          imageUrl: image2,
          source: sourceUrl,
        ),
      ],
    ),
  ];
}

String image1 =
    'https://images.pexels.com/photos/7065187/pexels-photo-7065187.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';
String image2 =
    'https://images.pexels.com/photos/4202952/pexels-photo-4202952.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';
String image3 =
    'https://images.pexels.com/photos/6941028/pexels-photo-6941028.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';
String sourceUrl = 'pexels.com';
