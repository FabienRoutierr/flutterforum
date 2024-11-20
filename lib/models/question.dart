import 'answer.dart';

class Question {
  final String id;
  final String pseudo;
  final String title;
  final String content;
  final List<Answer> answers;

  Question({
    required this.id,
    required this.pseudo,
    required this.title,
    required this.content,
    this.answers = const [],
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    var list = json['answers'] as List;
    List<Answer> answersList = list.map((i) => Answer.fromJson(i)).toList();
    
    return Question(
      id: json['id'],
      pseudo: json['pseudo'],
      title: json['title'],
      content: json['content'],
      answers: answersList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pseudo': pseudo,
      'title': title,
      'content': content,
      'answers': answers.map((answer) => answer.toJson()).toList(),
    };
  }
}

