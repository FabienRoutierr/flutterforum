import 'package:flutter/material.dart';
import '../models/question.dart';
import 'add_answer_page.dart';
import '../services/storage_service.dart';

class QuestionDetailPage extends StatefulWidget {
  final Question question;

  QuestionDetailPage({required this.question});

  @override
  _QuestionDetailPageState createState() => _QuestionDetailPageState();
}

class _QuestionDetailPageState extends State<QuestionDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.question.title)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start, 
              children: [
                Text(
                  "${widget.question.pseudo}: ",
                  style: TextStyle(
                    fontSize: 18, 
                    color: Colors.brown, 
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.question.content, 
                    style: TextStyle(
                      fontSize: 18, 
                      color: Colors.black, 
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: widget.question.answers.length,
              itemBuilder: (context, index) {
                final answer = widget.question.answers[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0), 
                  child: Container(
                    alignment: Alignment.centerLeft, 
                    padding: const EdgeInsets.all(8.0),
                    
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, 
                      children: [
                        Text(
                          "${answer.pseudo}: ", 
                          style: TextStyle(
                            fontSize: 18, 
                            color: Colors.brown, 
                          ),
                        ),
                        Text(
                          answer.content, 
                          style: TextStyle(
                            fontSize: 18, 
                            color: Colors.black, 
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0), 
            child: ElevatedButton(
              onPressed: () async {
                final response = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddAnswerPage(question: widget.question),
                  ),
                );

                if (response != null) {
                  setState(() {
                    widget.question.answers.add(response);
                    StorageService.saveQuestions([widget.question]);
                  });
                }
              },
              child: Text('Répondre', style: TextStyle(fontSize: 18)), 
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32), 
              ),
            ),
          ),
        ],
      ),
    );
  }
}
