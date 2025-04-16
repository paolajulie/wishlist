import 'package:flutter/material.dart';
import '../models/wish_item.dart';

class WishItemCard extends StatelessWidget {
  final WishItem item;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const WishItemCard({
    super.key,
    required this.item,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ListTile(
        leading: const Icon(Icons.favorite_border, color: Colors.pink),
        title: Text(item.title),
        subtitle: Text(item.description),
        trailing: Wrap(
          spacing: 12,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.pink),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.pink),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
