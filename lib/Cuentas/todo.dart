class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', todoText: 'Moises Torrez', isDone: true ),
      ToDo(id: '02', todoText: 'Arturo peniche', isDone: true ),
      ToDo(id: '03', todoText: 'Jose Colmenarez', ),
      ToDo(id: '04', todoText: 'Rebeca Mariño', ),
      ToDo(id: '05', todoText: 'Yajaira Ramones', ),
      ToDo(id: '06', todoText: 'Maria Alejos', ),
    ];
  }
}