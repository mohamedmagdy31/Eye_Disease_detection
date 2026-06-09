import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // قائمة وهمية بالفحوصات السابقة لعرضها أمام لجنة المناقشة
    final List<Map<String, String>> scanHistory = [
      {'date': '2026-06-01', 'result': 'Normal (سليم)', 'status': 'Safe'},
      {'date': '2026-05-15', 'result': 'Mild Cataract (مياه بيضاء خفيفة)', 'status': 'Warning'},
      {'date': '2026-04-20', 'result': 'Normal (سليم)', 'status': 'Safe'},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('سجل الفحوصات', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: scanHistory.length,
        itemBuilder: (context, index) {
          final item = scanHistory[index];
          final isSafe = item['status'] == 'Safe';

          return Card(
            margin: const EdgeInsets.only(bottom: 15),
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Icon(
                isSafe ? Icons.check_circle : Icons.warning,
                color: isSafe ? Colors.green : Colors.orange,
                size: 30,
              ),
              title: Text(
                item['result']!,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Text('تاريخ الفحص: ${item['date']}'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ),
          );
        },
      ),
    );
  }
}