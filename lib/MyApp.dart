import 'package:flutter/material.dart';
import 'package:todo_list/Task.dart';

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  final _contentController = TextEditingController();
  bool _isFilter = false;
  Task _task = Task.createDefault();
  List<Task> _tasks = [];
  List<Task> _filterTasks = [];

  @override
  Widget build(Object context) {
    // TODO: implement build
    return Center(
      child: Column(children: <Widget>[
        Expanded(
            child: SingleChildScrollView(
          child: Column(
            children: [
              for (Task task in _isFilter ? _filterTasks : _tasks)
                Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    color: Colors.white,
                    child: ListTile(
                      onTap: () {
                        setState(() {
                          task.isDone = !task.isDone;
                        });
                      },
                      title: task.isDone
                          ? Text(task.content,
                              style: const TextStyle(
                                  decoration: TextDecoration.lineThrough))
                          : Text(task.content),
                      leading: Checkbox(
                        value: task.isDone,
                        onChanged: ((value) {
                          setState(() {
                            task.isDone = !task.isDone;
                          });
                        }),
                      ),
                      trailing: Container(
                        child: IconButton(
                          color: Colors.red,
                          iconSize: 30,
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              _tasks.removeWhere((item) => item.id == task.id);
                              if (_isFilter) {
                                _filterTasks
                                    .removeWhere((item) => item.id == task.id);
                              }
                            });
                          },
                        ),
                      ),
                    ))
            ],
          ),
        )),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.teal),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white)),
                      onPressed: () {
                        setState(() {
                          _isFilter = false;
                          _tasks.sort((a, b) => a.isDone == b.isDone
                              ? 0
                              : a.isDone
                                  ? 1
                                  : -1);
                        });
                      },
                      child: Text("All")),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.green),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white)),
                      onPressed: () {
                        setState(() {
                          _filterTasks.clear();
                          _isFilter = true;
                          for (Task task in _tasks) {
                            if (task.isDone) {
                              _filterTasks.add(task);
                            }
                          }
                        });
                      },
                      child: Text("Completed")),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.grey),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white)),
                      onPressed: () {
                        setState(() {
                          _filterTasks.clear();
                          _isFilter = true;
                          for (Task task in _tasks) {
                            if (!task.isDone) {
                              _filterTasks.add(task);
                            }
                          }
                        });
                      },
                      child: Text("Not completed"))
                ],
              ),
              TextField(
                controller: _contentController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter something',
                ),
                onChanged: (text) {
                  _task.content = text;
                },
              ),
              Row(children: [
                Checkbox(
                    value: _task.isDone,
                    onChanged: (value) {
                      setState(() {
                        _task.isDone = !_task.isDone;
                      });
                    }),
                Text("Completed"),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 70),
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white)),
                            onPressed: () {
                              setState(() {
                                if (_task.content != '') {
                                  _tasks.add(_task);
                                  if (_isFilter) _filterTasks.add(_task);
                                  print(_task);
                                  _contentController.clear;
                                  _contentController.text = '';
                                  _task = Task.createDefault();
                                }
                              });
                            },
                            child: Text("New task"))))
              ]),
            ],
          ),
        )
      ]),
    );
  }
}
