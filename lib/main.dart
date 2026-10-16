import 'package:flutter/material.dart';

void main() => runApp(const RehlaApp());

class RehlaApp extends StatelessWidget {
  const RehlaApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'رحلة نحو عالم البرمجه',
      theme: ThemeData(fontFamily: 'Cairo'),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 4;
  int currentLesson = 0;
  bool showQ = false;
  bool answered = false;
  bool isCorrect = false;
  int completed = 0;

  final lessons = [
    {"q": "أي أمر يطبع في بايثون؟", "t": "أول خطوة في البرمجة هي الطباعة", "a1": 'print("مرحبا!")', "a2": 'echo "مرحبا!"', "correct": true, "exp": "print هي الصح في بايثون 💙"},
    {"q": "كيف نعمل متغير؟", "t": "المتغير هو صندوق يحفظ قيمة", "a1": 'x = 5', "a2": '5 = x', "correct": true, "exp": "بنحط الاسم يساوي القيمة"},
    {"q": "أي نوع بيانات نصي؟", "t": "النصوص اسمها String", "a1": '"أحلام"', "a2": '123', "correct": true, "exp": "النص لازم يكون بين علامتين"},
    {"q": "كيف نعمل شرط if؟", "t": "الشرط بيخلي الكود يفكر", "a1": 'if x > 5:', "a2": 'if x > 5 then', "correct": true, "exp": "بايثون بتحب النقطتين :"},
    {"q": "أي حلقة تكرر 3 مرات؟", "t": "for loop للتكرار", "a1": 'for i in range(3):', "a2": 'loop 3 times', "correct": true, "exp": "range(3) بتعد 0,1,2"},
  ];

  void answer(bool val) {
    setState(() {
      answered = true;
      isCorrect = val == lessons[currentLesson]["correct"];
      if(isCorrect) completed++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentIndex==3? const Color(0xFF111827) : const Color(0xFFFFF8F0),
      body: SafeArea(child: _buildBody()),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20)), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)]),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (i){ setState((){ currentIndex=i; showQ=false; answered=false; }); },
          selectedItemColor: const Color(0xFF8A6EFF),
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.build), label: 'محررات'),
            BottomNavigationBarItem(icon: Icon(Icons.info), label: 'سيرة التطبيق'),
            BottomNavigationBarItem(icon: Icon(Icons.emoji_events), label: 'الشهايد'),
            BottomNavigationBarItem(icon: Icon(Icons.palette), label: 'التيمات'),
            BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'الدروس'),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(){
    if(currentIndex==4) return _lessonsView();
    if(currentIndex==3) return _themesView();
    if(currentIndex==2) return _certsView();
    if(currentIndex==1) return _aboutView();
    return _editorsView();
  }

  Widget _card({required Widget child}){
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(28), boxShadow: [BoxShadow(color: Colors.black.withOpacity(.08), blurRadius: 30, offset: Offset(0,8))]),
      child: child,
    );
  }

  Widget _lessonsView(){
    return SingleChildScrollView(
      child: Column(children: [
        _card(child: Column(children: [
          Container(width: 200, height: 200, decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFFFEF6E9), border: Border.all(color: Colors.white, width: 6), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20)]),
            child: ClipOval(child: Icon(Icons.smart_toy_rounded, size: 110, color: Color(0xFF8A6EFF)))),
          const SizedBox(height: 12),
          if(!showQ)...[
            const Text('رحلة نحو عالم البرمجه 🚀', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('جاهز؟ ${lessons.length} دروس و ${lessons.length*5} تحدي من الصفر للاحتراف!', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 16),
            SizedBox(width: double.infinity, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF8A6EFF), padding: EdgeInsets.all(14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))), onPressed: (){ setState(()=> showQ=true); }, child: const Text('ابدأ التحدي 💻', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))))
          ] else...[
            Text(lessons[currentLesson]["q"] as String, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(lessons[currentLesson]["t"] as String, style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 16),
            SizedBox(width: double.infinity, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF002EFF), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))), onPressed: answered? null : ()=> answer(true), child: Text(lessons[currentLesson]["a1"] as String, style: TextStyle(color: Colors.white)))),
            SizedBox(width: double.infinity, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFE9ECFF), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))), onPressed: answered? null : ()=> answer(false), child: Text(lessons[currentLesson]["a2"] as String, style: TextStyle(color: Color(0xFF0A1931))))),
            if(answered)...[
              const SizedBox(height: 12),
              Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: isCorrect? Color(0xFFF0FDF4) : Color(0xFFFEF2F2), borderRadius: BorderRadius.circular(12), border: Border.all(color: isCorrect? Colors.green : Colors.red)), child: Text(isCorrect? 'صح برافو! 🎉\n${lessons[currentLesson]["exp"]}' : 'حاول تاني 💪\n${lessons[currentLesson]["exp"]}', textAlign: TextAlign.center)),
              const SizedBox(height: 10),
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: (){ if(currentLesson < lessons.length-1){ setState((){ currentLesson++; answered=false; }); } else { setState(()=> showQ=false); } }, child: Text(currentLesson < lessons.length-1? 'التالي →' : 'خلصت الدروس ✅'))),
            ]
          ]
        ])),
      ]),
    );
  }

  Widget _themesView() => _card(child: Column(children: [Text('🎨 التيمات', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), SizedBox(height: 12), ElevatedButton(onPressed: (){}, child: Text('☀️ فاتح كيوت'))]));
  Widget _certsView() => _card(child: Column(children: [Text('🏅 الشهادات', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), SizedBox(height: 12), LinearProgressIndicator(value: completed/lessons.length, color: Color(0xFF002EFF)), SizedBox(height: 8), Text('$completed / ${lessons.length}')]));
  Widget _aboutView() => _card(child: const Text('📖 سيرة التطبيق\n\nتطبيق كود أكاديمي للجميع\n22 درس - 110 تحدي\nانسخ → افهم → عدل → ابتكر', textAlign: TextAlign.right, style: TextStyle(height: 1.6)));
  Widget _editorsView() => _card(child: const Text('🛠️ محررات مقترحة\n\nReplit.com\nPydroid 3\nVS Code\nKlencod IDE', style: TextStyle(height: 1.6)));
}