import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'English AI',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3348C5)),
          scaffoldBackgroundColor: const Color(0xFFF6F7FB),
          cardTheme: const CardThemeData(
            elevation: 0,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
          ),
        ),
        home: const Directionality(textDirection: TextDirection.rtl, child: Login()),
      );
}

class Login extends StatelessWidget {
  const Login({super.key});
  void enter(BuildContext context, bool admin) => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => Shell(admin: admin)));
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 460),
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  Container(width: 82, height: 82, decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF3348C5), Color(0xFF7B61FF)]), borderRadius: BorderRadius.circular(26)), child: const Icon(Icons.auto_awesome, color: Colors.white, size: 42)),
                  const SizedBox(height: 20),
                  const Text('English AI', style: TextStyle(fontSize: 34, fontWeight: FontWeight.w900)),
                  const Text('تعلّم الإنجليزية من A1 إلى C2 بمسار شخصي ذكي', style: TextStyle(color: Colors.black54, fontSize: 17, height: 1.5)),
                  const SizedBox(height: 20),
                  const Notice(),
                  const SizedBox(height: 16),
                  const TextField(decoration: InputDecoration(labelText: 'البريد الإلكتروني', prefixIcon: Icon(Icons.alternate_email), filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(16))))),
                  const SizedBox(height: 10),
                  const TextField(obscureText: true, decoration: InputDecoration(labelText: 'كلمة المرور', prefixIcon: Icon(Icons.lock_outline), filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(16))))),
                  const SizedBox(height: 14),
                  FilledButton.icon(onPressed: () => enter(context, false), icon: const Icon(Icons.school_outlined), label: const Padding(padding: EdgeInsets.symmetric(vertical: 13), child: Text('تجربة التطبيق كمتعلم'))),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(onPressed: () => enter(context, true), icon: const Icon(Icons.admin_panel_settings_outlined), label: const Padding(padding: EdgeInsets.symmetric(vertical: 13), child: Text('الدخول كمدير تجريبي'))),
                  const SizedBox(height: 12),
                  const Text('هذه النسخة لا تحفظ كلمة المرور ولا تتصل بخادم.', textAlign: TextAlign.center, style: TextStyle(color: Colors.black54, fontSize: 12)),
                ]),
              ),
            ),
          ),
        ),
      );
}

class Notice extends StatelessWidget {
  const Notice({super.key});
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(color: const Color(0xFFFFF7DB), border: Border.all(color: const Color(0xFFFFD66B)), borderRadius: BorderRadius.circular(16)),
        child: const Row(children: [Icon(Icons.science_outlined, color: Color(0xFF8A6500)), SizedBox(width: 9), Expanded(child: Text('نسخة تجريبية محلية تعمل دون إنترنت ببيانات نموذجية.', style: TextStyle(color: Color(0xFF6B5200), height: 1.5)))]),
      );
}

class Shell extends StatefulWidget {
  const Shell({super.key, required this.admin});
  final bool admin;
  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  int page = 0;
  @override
  Widget build(BuildContext context) {
    final views = [Home(admin: widget.admin, move: (v) => setState(() => page = v)), const Learn(), const Review(), const Studio(), widget.admin ? const Admin() : const Profile()];
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: IndexedStack(index: page, children: views),
        bottomNavigationBar: NavigationBar(
          selectedIndex: page,
          onDestinationSelected: (v) => setState(() => page = v),
          destinations: [
            const NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'الرئيسية'),
            const NavigationDestination(icon: Icon(Icons.route_outlined), selectedIcon: Icon(Icons.route), label: 'التعلم'),
            const NavigationDestination(icon: Icon(Icons.style_outlined), selectedIcon: Icon(Icons.style), label: 'المراجعة'),
            const NavigationDestination(icon: Icon(Icons.mic_none), selectedIcon: Icon(Icons.mic), label: 'التدريب'),
            NavigationDestination(icon: Icon(widget.admin ? Icons.admin_panel_settings_outlined : Icons.person_outline), selectedIcon: Icon(widget.admin ? Icons.admin_panel_settings : Icons.person), label: widget.admin ? 'الإدارة' : 'حسابي'),
          ],
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key, required this.admin, required this.move});
  final bool admin;
  final ValueChanged<int> move;
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('صباح الخير، مصطفى', style: TextStyle(fontWeight: FontWeight.w900)), Text('مستواك الحالي B1', style: TextStyle(fontSize: 12, color: Colors.black54))]), actions: [IconButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('لديك إشعاران جديدان'))), icon: const Icon(Icons.notifications_none))]),
        body: ListView(padding: const EdgeInsets.fromLTRB(18, 6, 18, 28), children: [
          const Notice(),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF3348C5), Color(0xFF7356E8)]), borderRadius: BorderRadius.circular(24)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Row(children: [Expanded(child: Text('هدفك اليوم', style: TextStyle(color: Colors.white70))), Text('14 / 25 دقيقة', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))]),
              const SizedBox(height: 10),
              const LinearProgressIndicator(value: .56, minHeight: 9, backgroundColor: Colors.white24, valueColor: AlwaysStoppedAnimation(Colors.white)),
              const SizedBox(height: 18),
              const Text('متابعة درس اليوم', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900)),
              const Text('فهم التفاصيل في المحادثات اليومية', style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 12),
              FilledButton.icon(style: FilledButton.styleFrom(backgroundColor: Colors.white, foregroundColor: const Color(0xFF3348C5)), onPressed: () => move(1), icon: const Icon(Icons.play_arrow), label: const Text('متابعة')),
            ]),
          ),
          const SizedBox(height: 12),
          const Row(children: [Expanded(child: Metric('12', 'سلسلة الأيام', Icons.local_fire_department)), SizedBox(width: 8), Expanded(child: Metric('1,840', 'XP', Icons.bolt)), SizedBox(width: 8), Expanded(child: Metric('7', 'الشارات', Icons.workspace_premium))]),
          const SizedBox(height: 20),
          const TitleBlock('تدريب اليوم', 'خطة ذكية مدتها 25 دقيقة'),
          const SizedBox(height: 10),
          ActionTile(Icons.headphones, 'استماع: رحلة القطار', '8 دقائق • B1', () => move(1)),
          const SizedBox(height: 8),
          ActionTile(Icons.record_voice_over, 'نطق: Shadowing', '7 دقائق • تحسين الطلاقة', () => move(3)),
          const SizedBox(height: 8),
          ActionTile(Icons.spellcheck, 'مراجعة 12 كلمة', 'FSRS • مستحقة الآن', () => move(2)),
          const SizedBox(height: 20),
          const TitleBlock('تقدم المهارات', 'تقدير CEFR منفصل لكل مهارة'),
          const SizedBox(height: 10),
          const SkillCard(),
          if (admin) ...[const SizedBox(height: 16), FilledButton.icon(onPressed: () => move(4), icon: const Icon(Icons.admin_panel_settings), label: const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Text('فتح لوحة المدير')))],
        ]),
      );
}

class Metric extends StatelessWidget {
  const Metric(this.value, this.label, this.icon, {super.key});
  final String value;
  final String label;
  final IconData icon;
  @override
  Widget build(BuildContext context) => Card(child: Padding(padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 4), child: Column(children: [Icon(icon, color: const Color(0xFF3348C5)), const SizedBox(height: 4), Text(value, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 17)), Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 10, color: Colors.black54))])));
}

class TitleBlock extends StatelessWidget {
  const TitleBlock(this.title, this.subtitle, {super.key});
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900)), Text(subtitle, style: const TextStyle(color: Colors.black54))]);
}

class ActionTile extends StatelessWidget {
  const ActionTile(this.icon, this.title, this.subtitle, this.onTap, {super.key});
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Card(child: ListTile(onTap: onTap, leading: CircleAvatar(child: Icon(icon)), title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800)), subtitle: Text(subtitle), trailing: const Icon(Icons.chevron_left)));
}

class SkillCard extends StatelessWidget {
  const SkillCard({super.key});
  @override
  Widget build(BuildContext context) {
    const rows = [('الاستماع', .67, 'B1'), ('التحدث', .54, 'A2'), ('القراءة', .76, 'B2'), ('الكتابة', .48, 'A2'), ('المفردات', .64, 'B1')];
    return Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(children: [for (final r in rows) ...[Row(children: [SizedBox(width: 68, child: Text(r.$1, style: const TextStyle(fontWeight: FontWeight.bold))), Expanded(child: LinearProgressIndicator(value: r.$2, minHeight: 8)), const SizedBox(width: 8), Text(r.$3, style: const TextStyle(fontWeight: FontWeight.w900))]), if (r != rows.last) const SizedBox(height: 13)]])));
  }
}

class Learn extends StatelessWidget {
  const Learn({super.key});
  @override
  Widget build(BuildContext context) {
    const lessons = [('استماع في محطة القطار', 'B1 • 8 دقائق', Icons.headphones, false), ('مفردات السفر الذكية', 'B1 • 6 دقائق', Icons.translate, false), ('قواعد الماضي البسيط', 'A2 • 9 دقائق', Icons.account_tree, false), ('قراءة قصة قصيرة', 'B1 • 10 دقائق', Icons.menu_book, false), ('محادثة حجز فندق', 'B1 • 8 دقائق', Icons.record_voice_over, true)];
    return Scaffold(appBar: AppBar(title: const Text('مساري الشخصي', style: TextStyle(fontWeight: FontWeight.w900))), body: ListView(padding: const EdgeInsets.all(18), children: [const TitleBlock('خطة الأسبوع', 'أكملت 3 من 8 أنشطة'), const SizedBox(height: 12), for (var i = 0; i < lessons.length; i++) ...[Card(child: ListTile(onTap: lessons[i].$4 ? null : () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const Lesson())), leading: CircleAvatar(child: Icon(lessons[i].$4 ? Icons.lock : lessons[i].$3)), title: Text('${i + 1}. ${lessons[i].$1}', style: const TextStyle(fontWeight: FontWeight.w800)), subtitle: Text(lessons[i].$2), trailing: Icon(lessons[i].$4 ? Icons.lock_outline : Icons.chevron_left))), const SizedBox(height: 8)]]));
  }
}

class Lesson extends StatefulWidget {
  const Lesson({super.key});
  @override
  State<Lesson> createState() => _LessonState();
}

class _LessonState extends State<Lesson> {
  int step = 0;
  String answer = '';
  bool checked = false;
  @override
  Widget build(BuildContext context) {
    final parts = <Widget>[
      const Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.headphones, size: 80, color: Color(0xFF3348C5)), Text('الاستماع في محطة القطار', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900)), SizedBox(height: 8), Text('استمع للمحادثة والتقط رقم الرصيف ووقت الرحلة.')])),
      Card(child: Padding(padding: const EdgeInsets.all(20), child: Column(mainAxisSize: MainAxisSize.min, children: [IconButton.filled(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تشغيل نموذج صوتي'))), icon: const Icon(Icons.play_arrow), iconSize: 38), const SizedBox(height: 16), const Text('A: Which platform does the train leave from?\nB: It has changed to platform eight today.', style: TextStyle(fontSize: 18, height: 1.7))]))),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('من أي رصيف سيغادر القطار؟', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w900)), const SizedBox(height: 12), for (final v in ['السادس', 'الثامن', 'العاشر']) RadioListTile<String>(value: v, groupValue: answer, onChanged: checked ? null : (x) => setState(() => answer = x ?? ''), title: Text(v), tileColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))), if (checked) Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: answer == 'الثامن' ? const Color(0xFFE1F5E8) : const Color(0xFFFFE4E4), borderRadius: BorderRadius.circular(14)), child: Text(answer == 'الثامن' ? 'صحيح! الرصيف الثامن.' : 'الإجابة الصحيحة: الرصيف الثامن.'))]),
      const Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.emoji_events, size: 88, color: Colors.amber), Text('أكملت الدرس!', style: TextStyle(fontSize: 27, fontWeight: FontWeight.w900)), Text('85% • 25 XP • 6 دقائق')]))
    ];
    return Scaffold(appBar: AppBar(title: const Text('درس تفاعلي'), bottom: PreferredSize(preferredSize: const Size.fromHeight(6), child: LinearProgressIndicator(value: (step + 1) / parts.length, minHeight: 6))), body: Padding(padding: const EdgeInsets.all(20), child: parts[step]), bottomNavigationBar: SafeArea(child: Padding(padding: const EdgeInsets.all(16), child: FilledButton(onPressed: () { if (step == 2 && !checked) { if (answer.isEmpty) return; setState(() => checked = true); } else if (step == parts.length - 1) { Navigator.pop(context); } else { setState(() => step++); } }, child: Padding(padding: const EdgeInsets.symmetric(vertical: 13), child: Text(step == 2 && !checked ? 'تحقق' : step == parts.length - 1 ? 'إنهاء' : 'التالي'))))));
  }
}

class Review extends StatefulWidget {
  const Review({super.key});
  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  bool show = false;
  int n = 1;
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('المراجعة الذكية', style: TextStyle(fontWeight: FontWeight.w900))), body: Padding(padding: const EdgeInsets.all(20), child: Column(children: [Text('$n / 12'), const SizedBox(height: 8), LinearProgressIndicator(value: n / 12, minHeight: 8), const SizedBox(height: 22), Expanded(child: GestureDetector(onTap: () => setState(() => show = true), child: Card(child: SizedBox.expand(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [const Text('achievement', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900)), const Text('/əˈtʃiːvmənt/', style: TextStyle(color: Colors.black54)), if (show) ...[const Divider(height: 42), const Text('إنجاز', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800)), const SizedBox(height: 10), const Text('Finishing the course was a major achievement.', textAlign: TextAlign.center)] else ...[const SizedBox(height: 28), const Text('اضغط لإظهار المعنى', style: TextStyle(color: Colors.black45))]])))), const SizedBox(height: 12), if (show) Row(children: [for (final label in ['نسيت', 'صعب', 'جيد', 'سهل']) Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 3), child: FilledButton(onPressed: () => setState(() { n = n == 12 ? 1 : n + 1; show = false; }), child: Text(label, style: const TextStyle(fontSize: 11)))))) else FilledButton(onPressed: () => setState(() => show = true), child: const Text('إظهار الإجابة'))])));
}

class Studio extends StatelessWidget {
  const Studio({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('استوديو التدريب', style: TextStyle(fontWeight: FontWeight.w900))), body: ListView(padding: const EdgeInsets.all(18), children: [const TitleBlock('تحدث بطلاقة', 'قراءة وShadowing ومحادثات'), const SizedBox(height: 10), ActionTile(Icons.menu_book, 'القراءة بصوت عالٍ', 'الدقة والطلاقة والتنغيم', () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const Speak()))), const SizedBox(height: 8), ActionTile(Icons.graphic_eq, 'Shadowing', 'تقليد الإيقاع والسرعة', () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const Speak()))), const SizedBox(height: 8), ActionTile(Icons.forum_outlined, 'Role-play', 'محادثة حجز فندق', () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const Speak()))), const SizedBox(height: 20), const TitleBlock('الكتابة الذكية', 'تصحيح القواعد والأسلوب'), const SizedBox(height: 10), ActionTile(Icons.edit_note, 'كتابة بريد رسمي', 'تحليل وشرح فوري', () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const Write()))) ]));
}

class Speak extends StatefulWidget {
  const Speak({super.key});
  @override
  State<Speak> createState() => _SpeakState();
}

class _SpeakState extends State<Speak> {
  Timer? timer;
  bool recording = false;
  bool result = false;
  int seconds = 0;
  @override
  void dispose() { timer?.cancel(); super.dispose(); }
  void toggle() { if (recording) { timer?.cancel(); setState(() { recording = false; result = true; }); } else { setState(() { recording = true; result = false; seconds = 0; }); timer = Timer.periodic(const Duration(seconds: 1), (_) => setState(() => seconds++)); } }
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('تدريب التحدث')), body: ListView(padding: const EdgeInsets.all(20), children: [Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: const Color(0xFFE8ECFF), borderRadius: BorderRadius.circular(20)), child: const Text('I would like to book a room for two nights, please.', textAlign: TextAlign.center, style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800, height: 1.6))), const SizedBox(height: 26), Center(child: IconButton.filled(onPressed: toggle, icon: Icon(recording ? Icons.stop : Icons.mic), iconSize: 45, style: IconButton.styleFrom(minimumSize: const Size(95, 95), backgroundColor: recording ? Colors.red : const Color(0xFF3348C5)))), const SizedBox(height: 8), Text(recording ? 'جارٍ التسجيل: $seconds ثانية' : 'اضغط للتسجيل', textAlign: TextAlign.center), if (result) ...[const SizedBox(height: 22), const Row(children: [Expanded(child: Metric('86', 'الدقة', Icons.check_circle_outline)), SizedBox(width: 8), Expanded(child: Metric('78', 'الطلاقة', Icons.speed)), SizedBox(width: 8), Expanded(child: Metric('82', 'التنغيم', Icons.graphic_eq))]), const SizedBox(height: 12), const Card(child: Padding(padding: EdgeInsets.all(16), child: Text('نطقك واضح. حاول ربط would like to بسرعة أكبر وتقليل الوقفة قبل for two nights.', style: TextStyle(height: 1.6))))]]));
}

class Write extends StatefulWidget {
  const Write({super.key});
  @override
  State<Write> createState() => _WriteState();
}

class _WriteState extends State<Write> {
  final controller = TextEditingController(text: 'I want know when the course start and how much it cost.');
  bool result = false;
  @override
  void dispose() { controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('الكتابة الذكية')), body: ListView(padding: const EdgeInsets.all(18), children: [const Text('اكتب استفساراً رسمياً عن دورة', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)), const SizedBox(height: 12), TextField(controller: controller, minLines: 8, maxLines: 12, decoration: const InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderSide: BorderSide.none))), const SizedBox(height: 12), FilledButton.icon(onPressed: () => setState(() => result = true), icon: const Icon(Icons.auto_awesome), label: const Text('تحليل الكتابة')), if (result) ...[const SizedBox(height: 16), const Row(children: [Expanded(child: Metric('76', 'الإجمالي', Icons.grade_outlined)), SizedBox(width: 8), Expanded(child: Metric('70', 'القواعد', Icons.spellcheck))]), const SizedBox(height: 10), const Card(child: Padding(padding: EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('التصحيح المقترح', style: TextStyle(fontWeight: FontWeight.w900)), SizedBox(height: 8), Text('I would like to know when the course starts and how much it costs.', style: TextStyle(height: 1.6)), Divider(), Text('بعد would like نستخدم to know، ومع الفاعل المفرد نضيف s.', style: TextStyle(height: 1.6))])))] ]));
}

class Admin extends StatelessWidget {
  const Admin({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('لوحة الإدارة', style: TextStyle(fontWeight: FontWeight.w900))), body: ListView(padding: const EdgeInsets.all(18), children: [const Notice(), const SizedBox(height: 12), const Row(children: [Expanded(child: Metric('1,248', 'المستخدمون', Icons.people_alt_outlined)), SizedBox(width: 8), Expanded(child: Metric('318', 'نشطون أسبوعياً', Icons.monitor_heart_outlined))]), const SizedBox(height: 18), const TitleBlock('إدارة المنصة', 'المحتوى والحملات والتحليلات'), const SizedBox(height: 10), const StaticTile(Icons.library_books_outlined, 'صناعة المحتوى', '18 مسودة • 4 قيد المراجعة'), const SizedBox(height: 8), const StaticTile(Icons.campaign_outlined, 'الإشعارات والحملات', 'حملات فورية أو مجدولة'), const SizedBox(height: 8), const StaticTile(Icons.analytics_outlined, 'التحليلات المتقدمة', 'قمع التحويل وأداء الدروس'), const SizedBox(height: 18), const Card(child: Column(children: [ListTile(title: Text('محادثة في المطار'), subtitle: Text('B1 • Speaking'), trailing: Chip(label: Text('قيد المراجعة'))), Divider(height: 1), ListTile(title: Text('كتابة تقرير احترافي'), subtitle: Text('C1 • Writing'), trailing: Chip(label: Text('مسودة'))), Divider(height: 1), ListTile(title: Text('Everyday Routines'), subtitle: Text('A1 • Listening'), trailing: Chip(label: Text('منشور')))]))]));
}

class StaticTile extends StatelessWidget {
  const StaticTile(this.icon, this.title, this.subtitle, {super.key});
  final IconData icon;
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) => Card(child: ListTile(leading: CircleAvatar(child: Icon(icon)), title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800)), subtitle: Text(subtitle), trailing: const Icon(Icons.chevron_left)));
}

class Profile extends StatelessWidget {
  const Profile({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(body: SafeArea(child: Padding(padding: EdgeInsets.all(24), child: Column(children: [CircleAvatar(radius: 45, child: Icon(Icons.person, size: 44)), SizedBox(height: 12), Text('مصطفى', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900)), Text('B1 • هدف المحادثة والعمل'), SizedBox(height: 22), Card(child: Column(children: [ListTile(leading: Icon(Icons.flag_outlined), title: Text('الهدف اليومي'), trailing: Text('25 دقيقة')), Divider(height: 1), ListTile(leading: Icon(Icons.language), title: Text('اللهجة'), trailing: Text('أمريكية'))]))]))));
}
