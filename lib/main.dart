import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مصمم أغطية التقارير الأكاديمية',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ),
        textTheme: GoogleFonts.cairoTextTheme(ThemeData.dark().textTheme),
      ),
      builder: (context, child) => Directionality(
        textDirection: TextDirection.rtl,
        child: child!,
      ),
      home: const CoverScreen(),
    );
  }
}

class CoverScreen extends StatefulWidget {
  const CoverScreen({super.key});

  @override
  State<CoverScreen> createState() => _CoverScreenState();
}

class _CoverScreenState extends State<CoverScreen> {
  // الحقول الأساسية للغلاف الأكاديمي مع بيانات افتراضية دقيقة
  final TextEditingController _uniCtrl = TextEditingController(text: "الجامعة التقنية الشمالية");
  final TextEditingController _collegeCtrl = TextEditingController(text: "معهد الإدارة التقني نينوى");
  final TextEditingController _deptCtrl = TextEditingController(text: "قسم الإدارة القانونية");
  final TextEditingController _titleCtrl = TextEditingController(text: "المذاهب الفكرية في الالتزام وأثرها القانوني");
  final TextEditingController _studentCtrl = TextEditingController(text: "عبدالرحمن وليد هاشم");
  final TextEditingController _supervisorCtrl = TextEditingController(text: "د. اسم المشرف");
  final TextEditingController _yearCtrl = TextEditingController(text: "2025 - 2026 م");

  final ScreenshotController _screenshotController = ScreenshotController();
  int _selectedTemplate = 1;

  void _exportImage() async {
    final imageBytes = await _screenshotController.capture(pixelRatio: 3.0);
    if (imageBytes != null) {
      final directory = await getTemporaryDirectory();
      final imagePath = await File('${directory.path}/academic_cover.png').create();
      await imagePath.writeAsBytes(imageBytes);
      await Share.shareXFiles([XFile(imagePath.path)], text: 'غلاف التقرير الأكاديمي الرسمي');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مصمم أغطية التقارير الأكاديمية الاحترافي', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // بطاقة معاينة ورقة الغلاف (A4 Style متميزة)
                Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: AspectRatio(
                      aspectRatio: 1 / 1.414,
                      child: Screenshot(
                        controller: _screenshotController,
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: _buildBorderDecoration(),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.2),
                                blurRadius: 15,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // رأس الغلاف (الجامعة، الكلية، القسم)
                              Column(
                                children: [
                                  Text(_uniCtrl.text, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),
                                  const SizedBox(height: 2),
                                  Text(_collegeCtrl.text, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.black54)),
                                  const SizedBox(height: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: Colors.indigo.shade50,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(color: Colors.indigo.shade100),
                                    ),
                                    child: Text(_deptCtrl.text, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.indigo)),
                                  ),
                                ],
                              ),
                              
                              // عنوان التقرير في المنتصف بتصميم فخم
                              Column(
                                children: [
                                  Container(width: 40, height: 2.5, color: Colors.indigo),
                                  const SizedBox(height: 10),
                                  const Text("بحث / تقرير أكاديمي", style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.5)),
                                  const SizedBox(height: 8),
                                  Text(
                                    _titleCtrl.text,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.black87, height: 1.35),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(width: 40, height: 2.5, color: Colors.indigo),
                                ],
                              ),

                              // أسفل الغلاف (الطالب والمشرف والسنة)
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text("إعداد الطالب:", style: TextStyle(fontSize: 8.5, color: Colors.grey, fontWeight: FontWeight.bold)),
                                          const SizedBox(height: 2),
                                          Text(_studentCtrl.text, style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold, color: Colors.black87)),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          const Text("بإشراف الاستاذ:", style: TextStyle(fontSize: 8.5, color: Colors.grey, fontWeight: FontWeight.bold)),
                                          const SizedBox(height: 2),
                                          Text(_supervisorCtrl.text, style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold, color: Colors.black87)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(_yearCtrl.text, style: const TextStyle(fontSize: 9.5, fontWeight: FontWeight.bold, color: Colors.black54)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // قسم اختيار نمط الإطار الفاخر
                const Text("اختر نمط الإطار الأكاديمي:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.indigoAccent)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ChoiceChip(
                        label: const Center(child: Text("كلاسيكي مزدوج")),
                        selected: _selectedTemplate == 1,
                        onSelected: (bool selected) => setState(() => _selectedTemplate = 1),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ChoiceChip(
                        label: const Center(child: Text("شريط جانبي أزرق")),
                        selected: _selectedTemplate == 2,
                        onSelected: (bool selected) => setState(() => _selectedTemplate = 2),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ChoiceChip(
                        label: const Center(child: Text("إطار فاخر عريض")),
                        selected: _selectedTemplate == 3,
                        onSelected: (bool selected) => setState(() => _selectedTemplate = 3),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // حقول الإدخال المرتبطة مباشرة بالمعاينة
                _buildSectionHeader("معلومات المؤسسة الأكاديمية"),
                _buildField("الجامعة", _uniCtrl),
                _buildField("الكلية أو المعهد", _collegeCtrl),
                _buildField("القسم", _deptCtrl),
                
                const SizedBox(height: 10),
                _buildSectionHeader("تفاصيل محتوى التقرير"),
                _buildField("عنوان التقرير أو البحث", _titleCtrl, maxLines: 2),
                
                Row(
                  children: [
                    Expanded(child: _buildField("اسم الطالب", _studentCtrl)),
                    const SizedBox(width: 10),
                    Expanded(child: _buildField("اسم المشرف", _supervisorCtrl)),
                  ],
                ),
                _buildField("العام الدراسي", _yearCtrl),
                const SizedBox(height: 20),

                // زر التصدير والمشاركة بتصميم بارز
                ElevatedButton.icon(
                  onPressed: _exportImage,
                  icon: const Icon(Icons.download_rounded, size: 20),
                  label: const Text("حفظ ومشاركة الغلاف كصورة عالية الجودة", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 4.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.indigo.shade300),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        onChanged: (_) => setState(() {}),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 12),
          isDense: true,
          filled: true,
          fillColor: Colors.grey.shade900,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.indigo, width: 1.5)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        ),
      ),
    );
  }

  BoxBorder? _buildBorderDecoration() {
    if (_selectedTemplate == 1) {
      return Border.all(color: Colors.black87, width: 2.5);
    } else if (_selectedTemplate == 2) {
      return const Border(
        right: BorderSide(color: Colors.indigo, width: 8),
        top: BorderSide(color: Colors.black38, width: 0.5),
        left: BorderSide(color: Colors.black38, width: 0.5),
        bottom: BorderSide(color: Colors.black38, width: 0.5),
      );
    } else {
      return Border.all(color: Colors.indigo.shade900, width: 4.5);
    }
  }
}