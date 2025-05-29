import 'package:flutter/material.dart';
import 'package:worker_task_management_system/model/task.dart';
import 'package:worker_task_management_system/view/submitcompletionscreen.dart';

class TaskListScreen extends StatefulWidget {
  final List<Task> tasklist;
  const TaskListScreen({super.key, required this.tasklist});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Tasks",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
        backgroundColor: Colors.red.shade900,
        centerTitle: true,      
      ),
      body: widget.tasklist.isEmpty
        ? const Center(
            child: Text(
              "No Tasks Available",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          )
        :ListView.builder(
          itemCount: widget.tasklist.length,
          itemBuilder: (context,index){
          final task = widget.tasklist[index];
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 25, bottom: 10),
            child: Column(
              children:[
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => SubmitCompletionScreen(
                        task: task,
                      )
                    ));
                    // Handle tap if needed
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 255, 129, 129).withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Task Title: ${task.title}",
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Task Description: ",
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text("${task.description}",
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
                            Text("${task.dueDate}",
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
                            Text("${task.status}",
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ]
            ),
          );
        },
      ), 
    );
  }
}

