import 'package:flutter/material.dart';
import '../models/question.dart';
import 'add_question_page.dart';
import 'question_detail_page.dart';
import '../services/storage_service.dart';

class QuestionsListPage extends StatefulWidget {
  const QuestionsListPage({super.key});

  @override
  _QuestionsListPageState createState() => _QuestionsListPageState();
}

class _QuestionsListPageState extends State<QuestionsListPage> {
  List<Question> questions = [];

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    final loadedQuestions = await StorageService.loadQuestions();
    setState(() {
      questions = loadedQuestions;
    });
  }

  Future<void> _addQuestion(Question newQuestion) async {
    setState(() {
      questions.add(newQuestion);
    });
    await StorageService.saveQuestions(questions);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Topics'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.indigo),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: const Text('Accueil'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
            ListTile(
              title: const Text('Liste des Topics'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/questions');
              },
            ),
          ],
        ),
      ),
      body: questions.isEmpty
          ? Center(
              child: Text(
                'Aucun topic pour le moment. Créez-en un !',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  final question = questions[index];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(
                        question.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      subtitle: Text('par ${question.pseudo}'),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              QuestionDetailPage(question: question),
                        ),
                      ),
                      trailing:
                          const Icon(Icons.arrow_forward, color: Colors.indigo),
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddQuestionPage()),
        ).then((value) async {
          if (value != null) {
            await _addQuestion(value);
          }
        }),
        child: const Icon(Icons.add),
        backgroundColor: Colors.brown,
      ),
    );
  }
}
