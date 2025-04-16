import 'package:flutter/material.dart';
import '../models/wish_item.dart';
import '../services/storage_service.dart';
import 'item_form_screen.dart';
import '../widgets/wish_item_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _storage = StorageService();
  List<WishItem> _items = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    final loaded = await _storage.loadItems();
    setState(() => _items = loaded);
  }

  void _handleAddEdit(WishItem? item) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ItemFormScreen(item: item)),
    );

    if (result != null && result is WishItem) {
      final index = _items.indexWhere((e) => e.id == result.id);
      setState(() {
        if (index >= 0) {
          _items[index] = result;
          _showToast("Desejo atualizado com sucesso!");
        } else {
          _items.add(result);
          _showToast("Novo desejo adicionado!");
        }
        _storage.saveItems(_items);
      });
    }
  }

  void _handleDelete(String id) {
    setState(() {
      _items.removeWhere((e) => e.id == id);
      _storage.saveItems(_items);
      _showToast("Desejo removido!");
    });
  }

  void _showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.black),
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.white,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Sua Lista de Desejos'),
        backgroundColor: Colors.pink[400],
        foregroundColor: Colors.white,
      ),
      body: _items.isEmpty
          ? const Center(child: Text("Nenhum item ainda 😢"))
          : ListView.builder(
              itemCount: _items.length,
              itemBuilder: (_, index) {
                final item = _items[index];
                return WishItemCard(
                  item: item,
                  onEdit: () => _handleAddEdit(item),
                  onDelete: () => _handleDelete(item.id),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _handleAddEdit(null),
        label: const Text(
          'Novo Desejo',
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
