class WebtoonModel {
  final String title, thumb, id;

  WebtoonModel.fromJson(
      Map<String, dynamic> json) // json 초기화 시키는 방법 named constructor
      : title = json['title'],
        thumb = json['thumb'],
        id = json['id'];
}
