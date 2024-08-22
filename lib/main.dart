import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'item_repository.dart';
import 'item_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final itemRepository = ItemRepository();

    return Scaffold(
      appBar: AppBar(
        title: const Text('POC DEV ENV'),
      ),
      body: StreamBuilder<List<Item>>(
        stream: itemRepository.itemList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error loading data.'));
          }

          final items = snapshot.data ?? [];

          if (items.isEmpty) {
            return const Center(child: Text('No items available.'));
          }

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                leading: const Icon(Icons.list),
                title: Text(item.name),
                subtitle: Text(item.category),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${item.name} tapped!')),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
