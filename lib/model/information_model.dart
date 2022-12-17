class InformationModel {
  final String? title;
  final String? sourceUrl;
  final List<ListOfImages>? imagesData;

  InformationModel(this.title, this.sourceUrl, this.imagesData);
}

class ListOfImages {
  final String? imageUrl;
  final String? source;

  ListOfImages({this.imageUrl, this.source});
}
