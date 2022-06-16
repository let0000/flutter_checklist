import 'package:flutter/material.dart';
import '../model/todo.dart';

class TodoTile extends StatefulWidget {
  final Todo todo;
  final Function onDeleted;
  const TodoTile({Key? key, required this.todo, required this.onDeleted}) : super(key: key);

  @override
  _TodoTileState createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color evenItemColor = colorScheme.primary;

    return Material(
      child: AnimatedContainer(
        constraints: const BoxConstraints(minHeight: 60),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: widget.todo.finished ? Colors.grey : evenItemColor,
          borderRadius: BorderRadius.circular(12),
        ),
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
        child: Row(
          children: [
            Checkbox(
              key: widget.key,
              value: widget.todo.finished,
              onChanged: (checked) {
                widget.todo.finished = checked ?? false;
                widget.todo.save();
                setState(() {
                });
              },
            ),
            Expanded(
              child: Text(
                widget.todo.title,
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  decoration: widget.todo.finished
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onPressed: () {
                widget.onDeleted();
              },
            )
          ],
        ),
      ),
    );
  }
}
