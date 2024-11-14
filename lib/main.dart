import 'package:flutter/material.dart';
import 'package:my_state_management/state_manager/state_list.dart';
import 'package:my_state_management/widgets/state_builder.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'State Management Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ItemListScreen(),
    );
  }
}

class ItemListScreen extends StatefulWidget {
  @override
  _ItemListScreenState createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  final ListState<String> itemList = ListState([]);

  @override
  void dispose() {
    itemList.dispose();
    super.dispose();
  }

  void _addItem(String item) {
    itemList.addItem(item);
  }

  void _removeItem(int index) {
    itemList.removeItem(itemList.list[index]);
  }

  void _editItem(int index, String newItem) {
    itemList.list[index] = newItem;
    itemList.updateList();
  }

  void _showInputDialog({String? initialText, required Function(String) onSubmit}) {
    final TextEditingController controller = TextEditingController(text: initialText);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(initialText == null ? 'Add Item' : 'Edit Item'),
        content: TextField(controller: controller),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              onSubmit(controller.text);
              Navigator.pop(context);
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Item List')),
      body: StateBuilder<List<String>>(
        stream: itemList.stream,
        initialData: itemList.list,
        builder: (context, items) {
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(items[index]),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => _showInputDialog(
                        initialText: items[index],
                        onSubmit: (newText) => _editItem(index, newText),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _removeItem(index),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showInputDialog(
          onSubmit: (newItem) => _addItem(newItem),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
