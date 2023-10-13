class Task {
  String id;
  String content;
  bool isDone;

  Task({required this.id, required this.content, required this.isDone});

  static Task createDefault() {
    return Task(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: '',
        isDone: false);
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'id: $id, content: $content, isDone: $isDone';
  }
}
