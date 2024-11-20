import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/question.dart';

class AddQuestionPage extends StatefulWidget {
  AddQuestionPage({super.key});

  @override
  _AddQuestionPageState createState() => _AddQuestionPageState();
}

class _AddQuestionPageState extends State<AddQuestionPage> {
  final TextEditingController pseudoController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Créer un topic')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey, 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, 
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
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Titre'),
                maxLength: 100, 
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un titre'; 
                  }
                  return null; 
                },
                style: TextStyle(fontSize: 18), 
              ),
              SizedBox(height: 20),
              
              TextFormField(
                controller: contentController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 10,
                minLines: 5,
                keyboardType: TextInputType.multiline,
                maxLength: 500, 
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une description'; 
                  }
                  return null; 
                },
                style: TextStyle(fontSize: 18), 
              ),
              Spacer(), 
              ElevatedButton(
                onPressed: () {
                  
                  if (_formKey.currentState?.validate() ?? false) {
                    final question = Question(
                      id: Uuid().v4(),
                      pseudo: pseudoController.text,
                      title: titleController.text,
                      content: contentController.text,
                      answers: [],
                    );
                    Navigator.pop(context, question);
                  }
                },
                child: const Text('Publier', style: TextStyle(fontSize: 18)), 
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
