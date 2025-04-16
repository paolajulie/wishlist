class WishItem {
  String id;
  String title;
  String description;

  WishItem({
    required this.id,
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
      };

  factory WishItem.fromJson(Map<String, dynamic> json) => WishItem(
        id: json['id'],
        title: json['title'],
        description: json['description'],
      );
}
