import 'package:flutter/material.dart';
void main() => runApp(const PhoneRepairSchool());

class PhoneRepairSchool extends StatelessWidget {
  const PhoneRepairSchool({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Phone Repair School',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class Lesson {
  final String title; final String notes; final IconData icon;
  final String imageUrl; final String imageDesc;
  Lesson(this.title, this.notes, this.icon, this.imageUrl, this.imageDesc);
}
class Module {
  final String name; final IconData icon; final Color color; final List<Lesson> lessons;
  Module(this.name, this.icon, this.color, this.lessons);
}

List<Module> modules = [
  Module("1. TOOLS", Icons.build, Colors.orange, [
    Lesson("Screwdriver Set", "Types: Star, Philips, Pentalobe. Use correct size to avoid stripping screws.", Icons.handyman, "https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?w=600", "Screwdriver kit"),
    Lesson("Multimeter", "Check battery 3.7-4.2V, continuity, short. Red=+, Black=-. Set DC 20V.", Icons.electrical_services, "https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?w=600", "Digital Multimeter"),
    Lesson("ESD Mat & Tweezers", "ESD tweezers for ICs. Plastic spudger to open clips. Never metal on battery!", Icons.construction, "https://images.unsplash.com/photo-1593642632823-8f785ba67e45?w=600", "ESD Tools"),
  ]),
  Module("2. PHONE PARTS - WITH PHOTOS", Icons.phone_android, Colors.blue, [
    Lesson("Battery", "Li-ion 3.7V. Swollen = danger. NEVER puncture! Put in salt water outside shop.", Icons.battery_alert, "https://images.unsplash.com/photo-1619646176600-b7417fb53b1e?w=600", "Phone Battery"),
    Lesson("Motherboard", "Main board: CPU, EMMC, Power IC. Use ESD wrist strap. Don't touch gold contacts.", Icons.memory, "https://images.unsplash.com/photo-1591799264318-7e6ef8ddb7ea?w=600", "Motherboard"),
    Lesson("Screen LCD", "LCD shows image, Touch senses finger. If image ok but no touch = replace digitizer.", Icons.smartphone, "https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=600", "Phone Screen"),
    Lesson("Charging Port", "No.1 fault! Clean port with brush. Test: 5V in, 4.2V out. If no 4.2V = IC faulty.", Icons.battery_charging_full, "https://images.unsplash.com/photo-1586816001966-79b736744398?w=600", "Charging Flex"),
  ]),
  Module("3. OPENING & FAULTS", Icons.bug_report, Colors.red, [
    Lesson("Water Damage", "OFF now! Remove battery, clean with IPA 99% + toothbrush, dry 24h.", Icons.water_damage, "https://images.unsplash.com/photo-1581092918056-0c4c3b09a6b4?w=600", "Water Damage Board"),
    Lesson("No Sound/Mic", "Speaker=music, Earpiece=call, Mic=your voice. Test with voice recorder.", Icons.mic, "https://images.unsplash.com/photo-1592899677977-9bb10ba5386d?w=600", "Mic & Speaker"),
  ]),
];

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("📱 PHONE REPAIR SCHOOL V2"), backgroundColor: Colors.indigo, foregroundColor: Colors.white),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: modules.length,
        itemBuilder: (context, i) {
          final m = modules[i];
          return Card(child: ExpansionTile(
            leading: CircleAvatar(backgroundColor: m.color, child: Icon(m.icon, color: Colors.white)),
            title: Text(m.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            children: m.lessons.map((l) => ListTile(
              leading: ClipRRect(borderRadius: BorderRadius.circular(6), child: Image.network(l.imageUrl, width: 50, height: 50, fit: BoxFit.cover, errorBuilder: (_,__,___)=>Icon(l.icon, color: m.color))),
              title: Text(l.title),
              subtitle: Text("Tap to see photo"),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LessonPage(lesson: l, color: m.color))),
            )).toList(),
          ));
        },
      ),
    );
  }
}

class LessonPage extends StatelessWidget {
  final Lesson lesson; final Color color;
  const LessonPage({super.key, required this.lesson, required this.color});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(lesson.title), backgroundColor: color, foregroundColor: Colors.white),
      body: SingleChildScrollView(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(lesson.imageUrl, height: 250, width: double.infinity, fit: BoxFit.cover, errorBuilder: (_,__,___)=>Container(height: 250, color: color.withOpacity(0.2), child: Icon(lesson.icon, size: 80, color: color)))),
        const SizedBox(height: 10),
        Text(lesson.imageDesc, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        const Text("📝 NOTES:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 10),
        Text(lesson.notes, style: const TextStyle(fontSize: 16, height: 1.6)),
        const SizedBox(height: 20),
        Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.yellow[100], borderRadius: BorderRadius.circular(8)),
          child: const Text("💡 TIP: Take your own photos in your shop and replace imageUrl for 100% offline!")),
      ])),
    );
  }
}
