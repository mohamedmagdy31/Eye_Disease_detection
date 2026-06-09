import 'package:flutter/material.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> tips = [
      {'title': 'قاعدة 20-20-20', 'desc': 'كل 20 دقيقة نظر للشاشة، انظر لمسافة 20 قدم لمدة 20 ثانية لتريح عينك.', 'icon': Icons.timer},
      {'title': 'إضاءة الغرفة', 'desc': 'تجنب استخدام الهاتف في الظلام الدامس لتفادي إجهاد العين الزائد.', 'icon': Icons.lightbulb},
      {'title': 'الترطيب المستمر', 'desc': 'احرص على الرمش باستمرار أو استخدام قطرات مرطبة عند الجلوس طويلاً.', 'icon': Icons.water_drop},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('نصائح وإرشادات', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: tips.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              leading: Icon(tips[index]['icon'], color: Colors.teal),
              title: Text(tips[index]['title'], style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal)),
              subtitle: Text(tips[index]['desc']),
            ),
          );
        },
      ),
    );
  }
}