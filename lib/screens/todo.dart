import 'package:fireshipapp/buttons/dark_mode_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List<Task> tasks = [];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  void _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _loadTasks(); // Load tasks after initializing SharedPreferences
  }

  void _loadTasks() {
    List<String>? savedTasks = _prefs.getStringList('tasks');
    if (savedTasks != null) {
      setState(() {
        tasks = savedTasks.map((task) => Task(title: task)).toList();
      });
    }
  }

  void _saveTasks() {
    List<String> taskTitles = tasks.map((task) => task.title).toList();
    _prefs.setStringList('tasks', taskTitles);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        backgroundColor: Colors.deepPurple.shade400,
        actions: const [
          DarkModeButton(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Task input
            TextField(
              onSubmitted: (task) {
                // Add task
                setState(() {
                  tasks.add(Task(title: task));
                });
                _saveTasks(); // Save tasks after adding
                // Clear input
                clearInput();
              },
              decoration: InputDecoration(
                hintText: 'Add a task',
                suffixIcon: IconButton(
                  onPressed: () {
                    // Clear tasks
                    setState(() {
                      tasks.clear();
                    });
                    _saveTasks(); // Save tasks after clearing
                  },
                  icon: const Icon(Icons.clear),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Task list
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return TaskWidget(
                    task: tasks[index],
                    onDelete: () {
                      // Remove task
                      setState(() {
                        tasks.removeAt(index);
                      });
                      _saveTasks(); // Save tasks after deletion
                    },
                    onEdit: (newTitle) {
                      // Edit task
                      setState(() {
                        tasks[index].title = newTitle;
                      });
                      _saveTasks(); // Save tasks after editing
                    },
                    onCheck: () {
                      // Mark task as done
                      setState(() {
                        tasks[index].isDone = !tasks[index].isDone;
                      });
                      _saveTasks(); // Save tasks after checking
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void clearInput() {
    // Clear input
    FocusScope.of(context).unfocus();
    setState(() {
      // Clear input text
      (context.findRenderObject() as RenderBox).paintBounds;
    });
  }
}

class Task {
  String title;
  bool isDone;

  Task({required this.title, this.isDone = false});
}

class TaskWidget extends StatefulWidget {
  final Task task;
  final VoidCallback onDelete;
  final Function(String) onEdit;
  final VoidCallback onCheck;

  TaskWidget({
    required this.task,
    required this.onDelete,
    required this.onEdit,
    required this.onCheck,
  });

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  late TextEditingController _controller;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.task.title);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.task.isDone
          ? Colors.deepPurple.shade400
          : Colors.deepPurple.shade300,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: isEditing
              ? TextField(
                  controller: _controller,
                  onSubmitted: (newTitle) {
                    widget.onEdit(newTitle);
                    setState(() {
                      isEditing = false;
                    });
                  },
                )
              : Text(
                  widget.task.title,
                  style: TextStyle(
                    decoration:
                        widget.task.isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  isEditing ? Icons.check : Icons.edit,
                  color: Colors.blue,
                ),
                onPressed: () {
                  if (isEditing) {
                    widget.onEdit(_controller.text);
                  }
                  setState(() {
                    isEditing = !isEditing;
                  });
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: widget.onDelete,
              ),
              Checkbox(
                value: widget.task.isDone,
                onChanged: (value) {
                  widget.onCheck();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        hintColor: Colors.deepPurpleAccent,
        fontFamily: 'lato',
      ),
      home: TodoPage(),
    ),
  );
}
