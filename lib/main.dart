import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // استيراد مكتبة الـ Provider لإدارة الحالة
import 'app_context.dart';               // استيراد ملف الـ AppProvider اللي عملناه من شوية
import 'landing_page.dart';              // استيراد صفحة الهبوط الجديدة
import 'login_screen.dart';              // استيراد شاشة تسجيل الدخول الأصلية بتاعتكم

void main() {
  runApp(
    // لف التطبيق بالـ Provider عشان يشتغل كـ Context على كل الشاشات
    ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medical AI App',

      // جعل التطبيق يبدأ بصفحة الهبوط (Landing Page)
      home: const LandingPage(),

      // تعريف المسارات (Routes) للتنقل بين الشاشات بسلاسة
      routes: {
        '/login': (context) => const LoginScreen(),
        // يمكنك إضافة باقي مسارات الشاشات هنا مستقبلاً لو احتجت
      },

      // يمكنك تخصيص الألوان العامة للتطبيق هنا عشان تطابق الويب بالظبط لو تحب
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
    );
  }
}