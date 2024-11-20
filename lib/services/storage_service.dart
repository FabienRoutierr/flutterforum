import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/question.dart';

class StorageService {
  static Future<String> get _filePath async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/questions.json';
  }

  static Future<File> get _file async {
    final path = await _filePath;
    return File(path);
  }

  static Future<List<Question>> loadQuestions() async {
    try {
      final file = await _file;
      if (!(await file.exists())) return [];

      final contents = await file.readAsString();
      final List<dynamic> jsonData = json.decode(contents);

      return jsonData.map((json) => Question.fromJson(json)).toList();
    } catch (e) {
      print("Erreur de chargement des questions: $e");
      return [];
    }
  }

  static Future<void> saveQuestions(List<Question> questions) async {
    final file = await _file;
    final List<Map<String, dynamic>> jsonData =
        questions.map((q) => q.toJson()).toList();
    await file.writeAsString(json.encode(jsonData));
  }
}
