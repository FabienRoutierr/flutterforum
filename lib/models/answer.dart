class Answer {
  final String id;
  final String pseudo;
  final String content;

  Answer({
    required this.id,
    required this.pseudo,
    required this.content,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'pseudo': pseudo,
        'content': content,
      };

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['id'],
      pseudo: json['pseudo'],
      content: json['content'],
    );
  }
}
