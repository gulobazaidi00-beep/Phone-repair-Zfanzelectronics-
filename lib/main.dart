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
  final String title; final String notes; final IconData icon; final String imageDesc;
  Lesson(this.title, this.notes, this.icon, this.imageDesc);
}
class Module {
  final String name; final IconData icon; final Color color; final List<Lesson> lessons;
  Module(this.name, this.icon, this.color, this.lessons);
}

List<Module> modules = [
  Module("1. TOOLS", Icons.build, Colors.orange, [
    Lesson("Screwdriver Set", "Types: Star, Philips, Pentalobe. Use correct size to avoid stripping screws. Keep magnetic mat to hold screws.", Icons.handyman, "📷 6 screwdrivers in box"),
    Lesson("Multimeter", "Check battery 3.7-4.2V, continuity, short. Red=+, Black=-. Set DC 20V for battery test. Beep means short circuit.", Icons.electrical_services, "📷 Multimeter showing 3.82V"),
    Lesson("Tweezers & Spudger", "ESD tweezers for ICs. Plastic spudger to open clips. Never use metal to pry battery - fire risk!", Icons.construction, "📷 Blue spudger opening phone"),
  ]),
  Module("2. PHONE PARTS", Icons.phone_android, Colors.blue, [
    Lesson("Battery", "Li-ion 3.7V. Bad signs: swelling, fast drain. NEVER puncture swollen battery! Put in salt water outside.", Icons.battery_alert, "Diagram: Swollen vs Normal battery"),
    Lesson("Motherboard", "Main board: CPU, EMMC, Power IC. Use ESD wrist strap. Don't touch gold contacts.", Icons.memory, "Diagram: CPU, Power IC labeled"),
    Lesson("Screen", "LCD shows image, Touch senses finger. If image ok but no touch = replace digitizer only. Saves money.", Icons.smartphone, "📷 Separated LCD layers"),
    Lesson("Charging Port", "#1 fault! Clean port with brush. Test: 5V in, 4.2V out. If no 4.2V = Charging IC faulty.", Icons.battery_charging_full, "Diagram: USB pins"),
  ]),
  Module("3. OPENING PHONE", Icons.phonelink_setup, Colors.green, [
    Lesson("Step 1 - Power Off", "Power off! Remove SIM tray. Make screw map on paper. Different screws = different length!", Icons.power_settings_new, "📷 SIM ejector tool"),
    Lesson("Step 2 - Heat & Open", "Heat gun 80°C 2 min on edges to soften glue. Use suction cup + spudger. Go slowly.", Icons.heat_pump, "📷 Heating phone edge"),
    Lesson("Step 3 - Disconnect Battery FIRST", "Always disconnect battery connector first! This prevents short circuit burning board.", Icons.warning, "📷 Battery connector off"),
  ]),
  Module("4. COMMON FAULTS", Icons.bug_report, Colors.red, [
    Lesson("Not Powering On", "Check: 1) Battery >3.7V? 2) Try other battery 3) Power button ok? 4) Power IC output?", Icons.power_off, "Flowchart: Battery→Button→IC"),
    Lesson("Water Damage", "1) OFF now! 2) Remove battery 3) Clean with IPA 99% + toothbrush 4) Dry 24h. No hair dryer!", Icons.water_damage, "📷 Corroded vs Clean board"),
    Lesson("No Network", "SIM ok in other phone? Antenna cable connected? Check antenna contacts near battery.", Icons.signal_cellular_off, "📷 Antenna cable"),
    Lesson("No Sound/Mic", "Speaker=music, Earpiece=call, Mic=your voice. Test with voice recorder. Usually 2 screws only.", Icons.mic, "Diagram: Mic locations"),
  ]),
  Module("5. SOLDERING", Icons.fireplace, Colors.brown, [
    Lesson("Soldering Basics", "Temp 320°C small, 360°C big. Clean tip. Use flux! 2 second rule - don't burn board.", Icons.tips_and_updates, "📷 Tinning soldering tip"),
    Lesson("Jumper Wire", "For broken tracks. Scrape gently, flux, solder thin wire. Use magnifying glass.", Icons.cable, "📷 Jumper on board"),
  ]),
];

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("📱 PHONE REPAIR SCHOOL - OFFLINE"), backgroundColor: Colors.indigo, foregroundColor: Colors.white),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: modules.length,
        itemBuilder: (context, i) {
          final m = modules[i];
          return Card(child: ExpansionTile(
            leading: CircleAvatar(backgroundColor: m.color, child: Icon(m.icon, color: Colors.white)),
            title: Text(m.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("${m.lessons.length} lessons • Offline"),
            children: m.lessons.map((l) => ListTile(
              leading: Icon(l.icon, color: m.color),
              title: Text(l.title),
              subtitle: Text(l.imageDesc, style: const TextStyle(fontStyle: FontStyle.italic)),
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
        Container(height: 180, width: double.infinity, decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(12), border: Border.all(color: color)),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(lesson.icon, size: 70, color: color), const SizedBox(height: 10), Text(lesson.imageDesc, textAlign: TextAlign.center, style: TextStyle(color: color, fontWeight: FontWeight.bold))]),
        ),
        const SizedBox(height: 20),
        const Text("📝 NOTES:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 10),
        Text(lesson.notes, style: const TextStyle(fontSize: 16, height: 1.6)),
        const SizedBox(height: 20),
        Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.yellow[100], borderRadius: BorderRadius.circular(8)),
          child: const Text("💡 TIP: Practice on dead boards first! Take photo before disconnecting anything.", style: TextStyle(fontWeight: FontWeight.bold))),
      ])),
    );
  }
}
