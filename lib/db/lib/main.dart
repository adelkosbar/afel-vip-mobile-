import 'package:flutter/material.dart';
import 'db/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB.db;
  runApp(const AdelApp());
}

class AdelApp extends StatelessWidget {
  const AdelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adel VIP Mobile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {'title': 'المخزون', 'icon': Icons.inventory_2, 'color': Colors.blue},
      {'title': 'المبيعات', 'icon': Icons.shopping_cart, 'color': Colors.green},
      {'title': 'الصيانة', 'icon': Icons.build, 'color': Colors.orange},
      {'title': 'الفواتير', 'icon': Icons.receipt_long, 'color': Colors.purple},
      {'title': 'المصروفات', 'icon': Icons.money_off, 'color': Colors.red},
      {'title': 'التالف', 'icon': Icons.delete_outline, 'color': Colors.brown},
      {'title': 'العملاء', 'icon': Icons.people, 'color': Colors.teal},
      {'title': 'التقارير', 'icon': Icons.bar_chart, 'color': Colors.indigo},
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Adel VIP Mobile'),
          backgroundColor: Colors.blue[800],
          foregroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: items.map((e) {
              return InkWell(
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${e['title']} — قريبًا')),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: (e['color'] as Color).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: e['color'] as Color, width: 2),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(e['icon'] as IconData,
                          size: 46, color: e['color'] as Color),
                      const SizedBox(height: 8),
                      Text(e['title'] as String,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
