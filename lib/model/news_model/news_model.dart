class NewsModel {
  final String id;
  final String title;
  final String body;
  final String? imageUrl;
  final String? url;
  final String? source;
  final String publishedOn;

  NewsModel({
    required this.id,
    required this.title,
    required this.body,
    this.imageUrl,
    this.url,
    this.source,
    required this.publishedOn,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? 'Başlık Yok',
      body: json['body'] ?? 'Açıklama Yok',
      imageUrl: json['imageurl'],
      url: json['url'],
      source: json['source'],
      publishedOn:
          json['published_on'] != null
              ? DateTime.fromMillisecondsSinceEpoch(json['published_on'] * 1000).toString()
              : 'Bilinmiyor',
    );
  }
}
