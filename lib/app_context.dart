import 'package:flutter/material.dart';

// --- 1. Enums (البديل للـ Types في TypeScript) ---
enum UserRole { patient, doctor }

enum PageViewType { landing, dashboard, history, newScan, scanResults, settings }

enum ScanStatus { pending, diagnosed, reviewed, booked }

// --- 2. User Model ---
class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final UserRole? role;
  final String? specialization;
  final bool notificationsEnabled;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.role,
    this.specialization,
    required this.notificationsEnabled,
  });

  // دالة لعمل تحديث جزئي للبيانات (توازي الـ Partial في TS)
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    UserRole? role,
    String? specialization,
    bool? notificationsEnabled,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      specialization: specialization ?? this.specialization,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }
}

// --- 3. Scan Result Model ---
class ScanResultModel {
  final String id;
  final String patientId;
  final String patientName;
  final String complaint;
  final String? imageUrl;
  final String? diagnosis;
  final double? confidenceScore;
  final String? doctorNotes;
  final DateTime? appointmentDate;
  final String? appointmentTime;
  final ScanStatus status;
  final DateTime createdAt;

  ScanResultModel({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.complaint,
    this.imageUrl,
    this.diagnosis,
    this.confidenceScore,
    this.doctorNotes,
    this.appointmentDate,
    this.appointmentTime,
    required this.status,
    required this.createdAt,
  });

  ScanResultModel copyWith({
    String? id,
    String? patientId,
    String? patientName,
    String? complaint,
    String? imageUrl,
    String? diagnosis,
    double? confidenceScore,
    String? doctorNotes,
    DateTime? appointmentDate,
    String? appointmentTime,
    ScanStatus? status,
    DateTime? createdAt,
  }) {
    return ScanResultModel(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      patientName: patientName ?? this.patientName,
      complaint: complaint ?? this.complaint,
      imageUrl: imageUrl ?? this.imageUrl,
      diagnosis: diagnosis ?? this.diagnosis,
      confidenceScore: confidenceScore ?? this.confidenceScore,
      doctorNotes: doctorNotes ?? this.doctorNotes,
      appointmentDate: appointmentDate ?? this.appointmentDate,
      appointmentTime: appointmentTime ?? this.appointmentTime,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

// --- 4. App Provider (البديل للـ AppProvider والـ Context) ---
class AppProvider extends ChangeNotifier {
  // المتغيرات الخاصة بالـ State (Private)
  UserModel? _user;
  PageViewType _currentView = PageViewType.landing;
  List<ScanResultModel> _scanResults = []; // المصفوفة تبدأ فاضية تماماً كطلبك
  ScanResultModel? _currentScanResult;
  bool _isSidebarOpen = true;

  // الـ Getters لقراءة البيانات من الواجهات
  UserModel? get user => _user;
  PageViewType get currentView => _currentView;
  List<ScanResultModel> get scanResults => _scanResults;
  ScanResultModel? get currentScanResult => _currentScanResult;
  bool get isSidebarOpen => _isSidebarOpen;

  // --- Functions تعديل الحالة ---

  // تعيين مستخدم جديد بالكامل
  void setUser(UserModel? newUser) {
    _user = newUser;
    notifyListeners(); // دالة سحرية بتعمل إعادة بناء (rebuild) للشاشات تلقائياً
  }

  // تحديث جزئي لبيانات المستخدم الحالي
  void updateUser({
    String? name,
    String? email,
    String? phone,
    UserRole? role,
    String? specialization,
    bool? notificationsEnabled,
  }) {
    if (_user != null) {
      _user = _user!.copyWith(
        name: name,
        email: email,
        phone: phone,
        role: role,
        specialization: specialization,
        notificationsEnabled: notificationsEnabled,
      );
      notifyListeners();
    }
  }

  // تغيير الشاشة الحالية
  void setCurrentView(PageViewType view) {
    _currentView = view;
    notifyListeners();
  }

  // إضافة فحص جديد (البديل لـ addScanResult)
  void addScanResult({
    required String patientId,
    required String patientName,
    required String complaint,
    String? imageUrl,
    String? diagnosis,
    double? confidenceScore,
    String? doctorNotes,
    DateTime? appointmentDate,
    String? appointmentTime,
    required ScanStatus status,
  }) {
    final newResult = ScanResultModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(), // توليد ID فريد بناءً على الوقت
      patientId: patientId,
      patientName: patientName,
      complaint: complaint,
      imageUrl: imageUrl,
      diagnosis: diagnosis,
      confidenceScore: confidenceScore,
      doctorNotes: doctorNotes,
      appointmentDate: appointmentDate,
      appointmentTime: appointmentTime,
      status: status,
      createdAt: DateTime.now(),
    );

    _scanResults.insert(0, newResult); // إدخال الفحص في أول القائمة (توازي [newResult, ...prev])
    _currentScanResult = newResult;    // تعيينه كالفحص الحالي
    notifyListeners();
  }

  // تحديث فحص معين بناءً على الـ ID
  void updateScanResult(String id, {
    String? patientId,
    String? patientName,
    String? complaint,
    String? imageUrl,
    String? diagnosis,
    double? confidenceScore,
    String? doctorNotes,
    DateTime? appointmentDate,
    String? appointmentTime,
    ScanStatus? status,
  }) {
    _scanResults = _scanResults.map((scan) {
      if (scan.id == id) {
        return scan.copyWith(
          patientId: patientId,
          patientName: patientName,
          complaint: complaint,
          imageUrl: imageUrl,
          diagnosis: diagnosis,
          confidenceScore: confidenceScore,
          doctorNotes: doctorNotes,
          appointmentDate: appointmentDate,
          appointmentTime: appointmentTime,
          status: status,
        );
      }
      return scan;
    }).toList();

    // تحديث الفحص الحالي لو هو نفسه اللي اتعدل
    if (_currentScanResult?.id == id) {
      _currentScanResult = _scanResults.firstWhere((scan) => scan.id == id);
    }
    notifyListeners();
  }

  // تغيير الفحص الحالي النشط
  void setCurrentScanResult(ScanResultModel? result) {
    _currentScanResult = result;
    notifyListeners();
  }

  // فتح أو إغلاق القائمة الجانبية (Sidebar)
  void setSidebarOpen(bool open) {
    _isSidebarOpen = open;
    notifyListeners();
  }
}