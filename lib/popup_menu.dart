import 'package:flutter/material.dart';

class PopupMenu extends StatelessWidget {
  const PopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
        
        onSelected: (value) => {},
        itemBuilder: (context) => [
          const PopupMenuItem(value: 'all', child: Text('all')),
          const PopupMenuItem(value: 'done', child: Text('done')),
          const PopupMenuItem(value: 'undone', child: Text('undone')),
        ],
      );
  }
}