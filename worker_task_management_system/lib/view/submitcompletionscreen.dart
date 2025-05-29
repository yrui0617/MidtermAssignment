import 'package:flutter/material.dart';
import 'package:worker_task_management_system/model/task.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:worker_task_management_system/myconfig.dart';

class SubmitCompletionScreen extends StatefulWidget {
  final Task task;
  const SubmitCompletionScreen({super.key, required this.task});

  @override
  State<SubmitCompletionScreen> createState() => _SubmitCompletionScreen();
}

class _SubmitCompletionScreen extends State<SubmitCompletionScreen> {
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Submit Form",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
        backgroundColor: Colors.red.shade900,
        centerTitle: true,      
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
                child : Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.white, Color.fromARGB(255, 224, 231, 255)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.red.shade900,
                    width: 7,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 218, 218, 218).withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 4,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Task Title: ${widget.task.title}",
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Task Description: ",
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text("${widget.task.description}",
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Due Date: ",
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text("${widget.task.dueDate}",
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Status: ",
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text("${widget.task.status}",
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: textController,
                decoration: InputDecoration(
                  labelText: 'What did you complete?',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade900,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              onPressed: () {
                String inputText = textController.text;
                
                if (inputText.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please decribe what did you complete')),
                  );
                  return;
                }
                sumbitCompletion();
              },
              child: const Text('Submit',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        )
      )
    );
  }
  void sumbitCompletion() async {
    await http.post(
      Uri.parse("${MyConfig.myurl}/worker_task_management_system/php/submit_work.php"),
      body: {
        "work_id": widget.task.taskId,
        "worker_id": widget.task.workerId,
        "submission_text": textController.text,
      },
    ).then((response) {
      print(response.body); // helpful for debugging

      if (response.statusCode == 200) {
        var jsondata = json.decode(response.body);
        if (jsondata['status'] == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Success to submit !"),
          ));
          Navigator.of(context).pop();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Failed ! Please try again."),
          ));
        }
      }
    });
  
}
}