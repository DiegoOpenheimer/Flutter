

class Task {

  int id;
  String name;
  bool complete;

  Task({ this.id, this.name, this.complete });

  Task.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    complete = map['complete'] == 1 ? true : false;
  }

  Map<String, dynamic> toMap() => {
    'name': name,
    'complete': complete ? 1 : 0
  };

  @override
  String toString() {
    return 'Task{name: $name, complete: $complete}';
  }

}