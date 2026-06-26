import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(const EnglishAiDemo());

class EnglishAiDemo extends StatelessWidget {
  const EnglishAiDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'English AI',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3348C5)),
        scaffoldBackgroundColor: const Color(0xFFF6F7FB),
        cardTheme: const CardThemeData(
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
      ),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: DemoLogin(),
      ),
    );
  }
}

class DemoLogin extends StatelessWidget {
  const DemoLogin({super.key});

  void _open(BuildContext context, bool admin) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => DemoShell(admin: admin)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: 82,
                    height: 82,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF3348C5), Color(0xFF7B61FF)],
                      ),
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: const Icon(Icons.auto_awesome, color: Colors.white, size: 42),
                  ),
                  const SizedBox(height: 22),
                  const Text(
                    'English AI',
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'تعلّم الإنجليزية من A1 إلى C2 بمسار شخصي ذكي',
                    style: TextStyle(color: Colors.black54, fontSize: 17, height: 1.5),
                  ),
                  const SizedBox(height: 22),
                  const DemoNotice(),
                  const SizedBox(height: 18),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'البريد الإلكتروني',
                      prefixIcon: Icon(Icons.alternate_email),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'كلمة المرور',
                      prefixIcon: Icon(Icons.lock_outline),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: () => _open(context, false),
                    icon: const Icon(Icons.school_outlined),
                    label: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      child: Text('تجربة التطبيق كمتعلم'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton.icon(
                    onPressed: () => _open(context, true),
                    icon: const Icon(Icons.admin_panel_settings_outlined),
                    label: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      child: Text('الدخول كمدير تجريبي'),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'هذه النسخة لا تحفظ كلمة المرور ولا تتصل بخادم. الحساب الحقيقي يُفعّل بعد ربط Supabase.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black54, fontSize: 12, height: 1.5),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DemoNotice extends StatelessWidget {
  const DemoNotice({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7DB),
        border: Border.all(color: const Color(0xFFFFD66B)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.science_outlined, color: Color(0xFF8A6500)),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'نسخة تجريبية محلية تعمل دون إنترنت، وتعرض الوظائف الأساسية ببيانات نموذجية.',
              style: TextStyle(color: Color(0xFF6B5200), height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}

class DemoShell extends StatefulWidget {
  const DemoShell({super.key, required this.admin});
  final bool admin;

  @override
  State<DemoShell> createState() => _DemoShellState();
}

class _DemoShellState extends State<DemoShell> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      HomePage(admin: widget.admin, moveTo: (value) => setState(() => index = value)),
      const PathPage(),
      const ReviewPage(),
      const StudioPage(),
      widget.admin ? const AdminPage() : const ProfilePage(),
    ];
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: IndexedStack(index: index, children: pages),
        bottomNavigationBar: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: (value) => setState(() => index = value),
          destinations: [
            const NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'الرئيسية'),
            const NavigationDestination(icon: Icon(Icons.route_outlined), selectedIcon: Icon(Icons.route), label: 'التعلّم'),
            const NavigationDestination(icon: Icon(Icons.style_outlined), selectedIcon: Icon(Icons.style), label: 'المراجعة'),
            const NavigationDestination(icon: Icon(Icons.mic_none), selectedIcon: Icon(Icons.mic), label: 'التدريب'),
            NavigationDestination(
              icon: Icon(widget.admin ? Icons.admin_panel_settings_outlined : Icons.person_outline),
              selectedIcon: Icon(widget.admin ? Icons.admin_panel_settings : Icons.person),
              label: widget.admin ? 'الإدارة' : 'حسابي',
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.admin, required this.moveTo});
  final bool admin;
  final ValueChanged<int> moveTo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('صباح الخير، مصطفى', style: TextStyle(fontWeight: FontWeight.w900)),
            Text('مستواك الحالي B1', style: TextStyle(fontSize: 12, color: Colors.black54)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => showModalBottomSheet<void>(
              context: context,
              showDragHandle: true,
              builder: (_) => const Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(leading: Icon(Icons.auto_awesome), title: Text('تم تحديث مسارك الأسبوعي')),
                    ListTile(leading: Icon(Icons.style), title: Text('12 كلمة مستحقة للمراجعة')),
                  ],
                ),
              ),
            ),
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 6, 18, 28),
        children: [
          const DemoNotice(),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF3348C5), Color(0xFF7356E8)]),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(children: [Expanded(child: Text('هدفك اليوم', style: TextStyle(color: Colors.white70))), Text('14 / 25 دقيقة', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))]),
                const SizedBox(height: 12),
                const LinearProgressIndicator(value: .56, minHeight: 9, backgroundColor: Colors.white24, valueColor: AlwaysStoppedAnimation(Colors.white)),
                const SizedBox(height: 20),
                const Text('متابعة درس اليوم', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900)),
                const Text('فهم التفاصيل في المحادثات اليومية', style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 14),
                FilledButton.icon(
                  style: FilledButton.styleFrom(backgroundColor: Colors.white, foregroundColor: const Color(0xFF3348C5)),
                  onPressed: () => moveTo(1),
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('متابعة'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const Row(
            children: [
              Expanded(child: Metric(icon: Icons.local_fire_department, value: '12', label: 'سلسلة الأيام')),
              SizedBox(width: 8),
              Expanded(child: Metric(icon: Icons.bolt, value: '1,840', label: 'XP')),
              SizedBox(width: 8),
              Expanded(child: Metric(icon: Icons.workspace_premium, value: '7', label: 'الشارات')),
            ],
          ),
          const SizedBox(height: 22),
          const SectionTitle('تدريب اليوم', 'خطة ذكية مدتها 25 دقيقة'),
          const SizedBox(height: 10),
          TaskTile(icon: Icons.headphones, title: 'استماع: رحلة القطار', subtitle: '8 دقائق • B1', onTap: () => moveTo(1)),
          const SizedBox(height: 8),
          TaskTile(icon: Icons.record_voice_over, title: 'نطق: Shadowing', subtitle: '7 دقائق • تحسين الطلاقة', onTap: () => moveTo(3)),
          const SizedBox(height: 8),
          TaskTile(icon: Icons.spellcheck, title: 'مراجعة 12 كلمة', subtitle: 'FSRS • مستحقة الآن', onTap: () => moveTo(2)),
          const SizedBox(height: 22),
          const SectionTitle('تقدم المهارات', 'تقدير CEFR منفصل لكل مهارة'),
          const SizedBox(height: 10),
          const SkillsCard(),
          if (admin) ...[
            const SizedBox(height: 18),
            FilledButton.icon(
              onPressed: () => moveTo(4),
              icon: const Icon(Icons.admin_panel_settings),
              label: const Padding(padding: EdgeInsets.symmetric(vertical: 13), child: Text('فتح لوحة المدير')),
            ),
          ],
        ],
      ),
    );
  }
}

class Metric extends StatelessWidget {
  const Metric({super.key, required this.icon, required this.value, required this.label});
  final IconData icon;
  final String value;
  final String label;
  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 5),
          child: Column(children: [Icon(icon, color: const Color(0xFF3348C5)), const SizedBox(height: 5), Text(value, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 17)), Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, color: Colors.black54))]),
        ),
      );
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.title, this.subtitle, {super.key});
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900)), Text(subtitle, style: const TextStyle(color: Colors.black54))]);
}

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.icon, required this.title, required this.subtitle, required this.onTap});
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Card(
        child: ListTile(
          onTap: onTap,
          leading: CircleAvatar(child: Icon(icon)),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
          subtitle: Text(subtitle),
          trailing: const Icon(Icons.chevron_left),
        ),
      );
}

class SkillsCard extends StatelessWidget {
  const SkillsCard({super.key});
  @override
  Widget build(BuildContext context) {
    const data = [('الاستماع', .67, 'B1'), ('التحدث', .54, 'A2'), ('القراءة', .76, 'B2'), ('الكتابة', .48, 'A2'), ('المفردات', .64, 'B1')];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Column(
          children: [
            for (final item in data) ...[
              Row(children: [SizedBox(width: 70, child: Text(item.$1, style: const TextStyle(fontWeight: FontWeight.bold))), Expanded(child: LinearProgressIndicator(value: item.$2, minHeight: 8)), const SizedBox(width: 10), Text(item.$3, style: const TextStyle(fontWeight: FontWeight.w900))]),
              if (item != data.last) const SizedBox(height: 14),
            ],
          ],
        ),
      ),
    );
  }
}

class PathPage extends StatelessWidget {
  const PathPage({super.key});
  @override
  Widget build(BuildContext context) {
    const lessons = [
      ('استماع في محطة القطار', 'B1 • 8 دقائق', Icons.headphones, false),
      ('مفردات السفر الذكية', 'B1 • 6 دقائق', Icons.translate, false),
      ('قواعد الماضي البسيط', 'A2 • 9 دقائق', Icons.account_tree, false),
      ('قراءة قصة قصيرة', 'B1 • 10 دقائق', Icons.menu_book, false),
      ('محادثة حجز فندق', 'B1 • 8 دقائق', Icons.record_voice_over, true),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('مساري الشخصي', style: TextStyle(fontWeight: FontWeight.w900))),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const SectionTitle('خطة الأسبوع', 'أكملت 3 من 8 أنشطة'),
          const SizedBox(height: 14),
          for (var i = 0; i < lessons.length; i++) ...[
            Card(
              child: ListTile(
                onTap: lessons[i].$4 ? null : () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const LessonDemo())),
                leading: CircleAvatar(child: Icon(lessons[i].$4 ? Icons.lock : lessons[i].$3)),
                title: Text('${i + 1}. ${lessons[i].$1}', style: const TextStyle(fontWeight: FontWeight.w800)),
                subtitle: Text(lessons[i].$2),
                trailing: Icon(lessons[i].$4 ? Icons.lock_outline : Icons.chevron_left),
              ),
            ),
            const SizedBox(height: 9),
          ],
        ],
      ),
    );
  }
}

class LessonDemo extends StatefulWidget {
  const LessonDemo({super.key});
  @override
  State<LessonDemo> createState() => _LessonDemoState();
}

class _LessonDemoState extends State<LessonDemo> {
  int step = 0;
  String answer = '';
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    final screens = <Widget>[
      const Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.headphones, size: 80, color: Color(0xFF3348C5)), SizedBox(height: 18), Text('الاستماع في محطة القطار', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900)), SizedBox(height: 10), Text('استمع للمحادثة والتقط رقم الرصيف ووقت الرحلة.', textAlign: TextAlign.center)])),
      Card(child: Padding(padding: const EdgeInsets.all(20), child: Column(mainAxisSize: MainAxisSize.min, children: [IconButton.filled(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تشغيل صوت نموذجي في النسخة الإنتاجية.'))), icon: const Icon(Icons.play_arrow), iconSize: 38), const SizedBox(height: 18), const Text('A: Which platform does the train leave from?\nB: It has changed to platform eight today.', style: TextStyle(fontSize: 18, height: 1.8))]))),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('من أي رصيف سيغادر القطار؟', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w900)), const SizedBox(height: 14), for (final value in ['السادس', 'الثامن', 'العاشر']) RadioListTile<String>(value: value, groupValue: answer, onChanged: checked ? null : (v) => setState(() => answer = v ?? ''), title: Text(value), tileColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))), if (checked) Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: answer == 'الثامن' ? const Color(0xFFE1F5E8) : const Color(0xFFFFE4E4), borderRadius: BorderRadius.circular(14)), child: Text(answer == 'الثامن' ? 'صحيح! تغيّر الرصيف إلى الثامن.' : 'الإجابة الصحيحة: الرصيف الثامن.'))]),
      const Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.emoji_events, size: 88, color: Colors.amber), Text('أكملت الدرس!', style: TextStyle(fontSize: 27, fontWeight: FontWeight.w900)), SizedBox(height: 8), Text('85% • 25 XP • 6 دقائق')])),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('درس تفاعلي'), bottom: PreferredSize(preferredSize: const Size.fromHeight(6), child: LinearProgressIndicator(value: (step + 1) / screens.length, minHeight: 6))),
      body: Padding(padding: const EdgeInsets.all(20), child: screens[step]),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton(
            onPressed: () {
              if (step == 2 && !checked) {
                if (answer.isEmpty) return;
                setState(() => checked = true);
              } else if (step == screens.length - 1) {
                Navigator.pop(context);
              } else {
                setState(() => step++);
              }
            },
            child: Padding(padding: const EdgeInsets.symmetric(vertical: 13), child: Text(step == 2 && !checked ? 'تحقق' : step == screens.length - 1 ? 'إنهاء' : 'التالي')),
          ),
        ),
      ),
    );
  }
}

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});
  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  bool show = false;
  int number = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('المراجعة الذكية', style: TextStyle(fontWeight: FontWeight.w900))),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text('$number / 12'),
            const SizedBox(height: 8),
            LinearProgressIndicator(value: number / 12, minHeight: 8),
            const SizedBox(height: 24),
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => show = true),
                child: Card(
                  child: SizedBox.expand(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('achievement', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900)),
                          const Text('/əˈtʃiːvmənt/', style: TextStyle(color: Colors.black54)),
                          if (show) ...[
                            const Divider(height: 42),
                            const Text('إنجاز', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800)),
                            const SizedBox(height: 12),
                            const Text('Finishing the course was a major achievement.', textAlign: TextAlign.center),
                          ] else ...[
                            const SizedBox(height: 30),
                            const Text('اضغط لإظهار المعنى', style: TextStyle(color: Colors.black45)),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            if (show)
              Row(
                children: [
                  for (final label in ['نسيت', 'صعب', 'جيد', 'سهل'])
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: FilledButton(
                          onPressed: () => setState(() { number = number == 12 ? 1 : number + 1; show = false; }),
                          child: Text(label, style: const TextStyle(fontSize: 12)),
                        ),
                      ),
                    ),
                ],
              )
            else
              FilledButton(onPressed: () => setState(() => show = true), child: const Text('إظهار الإجابة')),
          ],
        ),
      ),
    );
  }
}

class StudioPage extends StatelessWidget {
  const StudioPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('استوديو التدريب', style: TextStyle(fontWeight: FontWeight.w900))),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const SectionTitle('تحدث بطلاقة', 'قراءة، Shadowing ومحادثات'),
          const SizedBox(height: 12),
          TaskTile(icon: Icons.menu_book, title: 'القراءة بصوت عالٍ', subtitle: 'الدقة والطلاقة والتنغيم', onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SpeakingDemo()))),
          const SizedBox(height: 8),
          TaskTile(icon: Icons.graphic_eq, title: 'Shadowing', subtitle: 'تقليد الإيقاع والسرعة', onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SpeakingDemo()))),
          const SizedBox(height: 8),
          TaskTile(icon: Icons.forum_outlined, title: 'Role-play', subtitle: 'محادثة حجز فندق', onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SpeakingDemo()))),
          const SizedBox(height: 22),
          const SectionTitle('الكتابة الذكية', 'تحليل القواعد والأسلوب'),
          const SizedBox(height: 12),
          TaskTile(icon: Icons.edit_note, title: 'كتابة بريد رسمي', subtitle: 'تصحيح وشرح فوري', onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const WritingDemo()))),
        ],
      ),
    );
  }
}

class SpeakingDemo extends StatefulWidget {
  const SpeakingDemo({super.key});
  @override
  State<SpeakingDemo> createState() => _SpeakingDemoState();
}

class _SpeakingDemoState extends State<SpeakingDemo> {
  Timer? timer;
  int seconds = 0;
  bool recording = false;
  bool result = false;
  @override
  void dispose() { timer?.cancel(); super.dispose(); }
  void toggle() {
    if (recording) {
      timer?.cancel();
      setState(() { recording = false; result = true; });
    } else {
      setState(() { recording = true; result = false; seconds = 0; });
      timer = Timer.periodic(const Duration(seconds: 1), (_) => setState(() => seconds++));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تدريب التحدث')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: const Color(0xFFE8ECFF), borderRadius: BorderRadius.circular(20)), child: const Text('I would like to book a room for two nights, please.', textAlign: TextAlign.center, style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800, height: 1.6))),
          const SizedBox(height: 28),
          Center(child: IconButton.filled(onPressed: toggle, icon: Icon(recording ? Icons.stop : Icons.mic), iconSize: 45, style: IconButton.styleFrom(minimumSize: const Size(95, 95), backgroundColor: recording ? Colors.red : const Color(0xFF3348C5)))),
          const SizedBox(height: 10),
          Text(recording ? 'جارٍ التسجيل: $seconds ثانية' : 'اضغط للتسجيل', textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)),
          if (result) ...[
            const SizedBox(height: 24),
            const Row(children: [Expanded(child: Metric(icon: Icons.check_circle_outline, value: '86', label: 'الدقة')), SizedBox(width: 8), Expanded(child: Metric(icon: Icons.speed, value: '78', label: 'الطلاقة')), SizedBox(width: 8), Expanded(child: Metric(icon: Icons.graphic_eq, value: '82', label: 'التنغيم'))]),
            const SizedBox(height: 14),
            const Card(child: Padding(padding: EdgeInsets.all(16), child: Text('نطقك واضح. حاول ربط “would like to” بسرعة أكبر وتقليل الوقفة قبل “for two nights”.', style: TextStyle(height: 1.6)))),
          ],
        ],
      ),
    );
  }
}

class WritingDemo extends StatefulWidget {
  const WritingDemo({super.key});
  @override
  State<WritingDemo> createState() => _WritingDemoState();
}

class _WritingDemoState extends State<WritingDemo> {
  final controller = TextEditingController(text: 'I want know when the course start and how much it cost.');
  bool result = false;
  @override
  void dispose() { controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الكتابة الذكية')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const Text('اكتب استفساراً رسمياً عن دورة', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
          const SizedBox(height: 14),
          TextField(controller: controller, minLines: 8, maxLines: 12, decoration: const InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderSide: BorderSide.none))),
          const SizedBox(height: 14),
          FilledButton.icon(onPressed: () => setState(() => result = true), icon: const Icon(Icons.auto_awesome), label: const Text('تحليل الكتابة')),
          if (result) ...[
            const SizedBox(height: 18),
            const Row(children: [Expanded(child: Metric(icon: Icons.grade_outlined, value: '76', label: 'الإجمالي')), SizedBox(width: 8), Expanded(child: Metric(icon: Icons.spellcheck, value: '70', label: 'القواعد'))]),
            const SizedBox(height: 12),
            const Card(child: Padding(padding: EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('التصحيح المقترح', style: TextStyle(fontWeight: FontWeight.w900)), SizedBox(height: 8), Text('I would like to know when the course starts and how much it costs.', style: TextStyle(height: 1.6)), Divider(), Text('بعد would like نستخدم to know، ومع الفاعل المفرد نضيف s إلى starts وcosts.', style: TextStyle(height: 1.6))]))),
          ],
        ],
      ),
    );
  }
}

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('لوحة الإدارة', style: TextStyle(fontWeight: FontWeight.w900))),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const DemoNotice(),
          const SizedBox(height: 14),
          const Row(children: [Expanded(child: Metric(icon: Icons.people_alt_outlined, value: '1,248', label: 'المستخدمون')), SizedBox(width: 8), Expanded(child: Metric(icon: Icons.monitor_heart_outlined, value: '318', label: 'نشطون أسبوعياً'))]),
          const SizedBox(height: 18),
          const SectionTitle('إدارة المنصة', 'المحتوى والحملات والتحليلات'),
          const SizedBox(height: 10),
          const TaskTileStatic(icon: Icons.library_books_outlined, title: 'صناعة المحتوى', subtitle: '18 مسودة • 4 قيد المراجعة'),
          const SizedBox(height: 8),
          const TaskTileStatic(icon: Icons.campaign_outlined, title: 'الإشعارات والحملات', subtitle: 'حملات فورية أو مجدولة'),
          const SizedBox(height: 8),
          const TaskTileStatic(icon: Icons.analytics_outlined, title: 'التحليلات المتقدمة', subtitle: 'قمع التحويل وأداء الدروس'),
          const SizedBox(height: 20),
          const SectionTitle('أحدث المحتوى', 'حالات النشر'),
          const SizedBox(height: 8),
          const Card(child: Column(children: [ListTile(title: Text('محادثة في المطار'), subtitle: Text('B1 • Speaking'), trailing: Chip(label: Text('قيد المراجعة'))), Divider(height: 1), ListTile(title: Text('كتابة تقرير احترافي'), subtitle: Text('C1 • Writing'), trailing: Chip(label: Text('مسودة'))), Divider(height: 1), ListTile(title: Text('Everyday Routines'), subtitle: Text('A1 • Listening'), trailing: Chip(label: Text('منشور')))])),
        ],
      ),
    );
  }
}

class TaskTileStatic extends StatelessWidget {
  const TaskTileStatic({super.key, required this.icon, required this.title, required this.subtitle});
  final IconData icon;
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) => Card(child: ListTile(leading: CircleAvatar(child: Icon(icon)), title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800)), subtitle: Text(subtitle), trailing: const Icon(Icons.chevron_left)));
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('حسابي')),
        body: const Padding(
          padding: EdgeInsets.all(20),
          child: Column(children: [CircleAvatar(radius: 45, child: Icon(Icons.person, size: 45)), SizedBox(height: 12), Text('مصطفى', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900)), Text('B1 • هدف المحادثة والعمل'), SizedBox(height: 22), Card(child: Column(children: [ListTile(leading: Icon(Icons.flag_outlined), title: Text('الهدف اليومي'), trailing: Text('25 دقيقة')), Divider(height: 1), ListTile(leading: Icon(Icons.language), title: Text('اللهجة'), trailing: Text('أمريكية'))]))]),
        ),
      );
}
