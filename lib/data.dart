

class memeModal {
  String images;

  memeModal(this.images);

  memeModal.fromJson(Map<String, dynamic>json){
    images = json['url'];
  }
}