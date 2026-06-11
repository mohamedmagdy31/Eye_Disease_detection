import 'package:flutter/material.dart';
import 'landing_page.dart'; // استيراد صفحة الهبوط الجديدة
import 'login_screen.dart';  // استيراد شاشة تسجيل الدخول الأصلية بتاعتكم

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // جعل التطبيق يبدأ بصفحة الهبوط (Landing Page) اللي لسه عاملينها
      home: const LandingPage(),

      // تعريف المسارات (Routes) عشان ننتقل لشاشة اللوجين بسلاسة لما تضغط على الأزرار
      routes: {
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}