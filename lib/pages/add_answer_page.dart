import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/question.dart';
import '../models/answer.dart';

class AddAnswerPage extends StatefulWidget {
  final Question question;

  AddAnswerPage({required this.question});

  @override
  _AddAnswerPageState createState() => _AddAnswerPageState();
}

class _AddAnswerPageState extends State<AddAnswerPage> {
  final TextEditingController pseudoController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Répondre à "${widget.question.title}"')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              
              TextFormField(
                controller: pseudoController,
                decoration: const InputDecoration(labelText: 'Pseudo'),
                maxLength: 30, 
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un pseudo'; 
                  }
                  return null; 
                },
                style: TextStyle(fontSize: 18), 
              ),
              SizedBox(height: 20),
              
              TextFormField(
                controller: contentController,
                decoration: const InputDecoration(labelText: 'Votre réponse'),
                maxLines: 5,
                minLines: 3,
                keyboardType: TextInputType.multiline,
                maxLength: 500, 
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une réponse'; 
                  }
                  return null; 
                },
                style: TextStyle(fontSize: 18), 
              ),
              Spacer(), 
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    final answer = Answer(
                      id: Uuid().v4(),
                      pseudo: pseudoController.text,
                      content: contentController.text,
                    );

                    Navigator.pop(context, answer);
                  }
                },
                child: const Text('Publier la réponse', style: TextStyle(fontSize: 18)), 
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32), 
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
