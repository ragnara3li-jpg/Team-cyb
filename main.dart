import 'package:flutter/material.dart';

void main() => runApp(const TeamCybApp());

class TeamCybApp extends StatelessWidget {
  const TeamCybApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TEAM-CYB',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4D8DFF),
          brightness: Brightness.dark,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int tab = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const ChatsScreen(),
      const DiscoverScreen(),
      const PremiumScreen(),
      const SettingsScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('TEAM-CYB',
            style: TextStyle(fontWeight: FontWeight.w800)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_rounded),
          ),
        ],
      ),
      body: pages[tab],
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (v) => setState(() => tab = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.chat_outlined), label: 'Chats'),
          NavigationDestination(icon: Icon(Icons.explore_outlined), label: 'Discover'),
          NavigationDestination(icon: Icon(Icons.star_outline), label: 'Premium'),
          NavigationDestination(icon: Icon(Icons.settings_outlined), label: 'Settings'),
        ],
      ),
      floatingActionButton: tab == 0
          ? FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.edit_rounded),
            )
          : null,
    );
  }
}

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      ('Arian', 'سلام، پروژه آماده شد؟', '20:41'),
      ('TEAM-CYB', 'به نسخهٔ آزمایشی خوش آمدید', '19:20'),
      ('Friends', 'یک فایل برایت ارسال شد', '18:05'),
    ];

    return ListView.separated(
      padding: const EdgeInsets.only(top: 8, bottom: 24),
      itemCount: items.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (_, i) {
        final x = items[i];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          leading: CircleAvatar(radius: 27, child: Text(x.$1[0])),
          title: Text(x.$1, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(x.$2),
          trailing: Text(x.$3),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ChatScreen(name: x.$1)),
          ),
        );
      },
    );
  }
}

class ChatScreen extends StatefulWidget {
  final String name;
  const ChatScreen({super.key, required this.name});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final input = TextEditingController();
  final messages = <String>[];

  void send() {
    final value = input.text.trim();
    if (value.isEmpty) return;
    setState(() {
      messages.add(value);
      input.clear();
    });
  }

  @override
  void dispose() {
    input.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.call_outlined)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.videocam_outlined)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(14),
              itemCount: messages.length,
              itemBuilder: (_, i) {
                final text = messages[messages.length - i - 1];
                return Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(text),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
              child: Row(
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.attach_file)),
                  Expanded(
                    child: TextField(
                      controller: input,
                      onSubmitted: (_) => send(),
                      decoration: InputDecoration(
                        hintText: 'پیام بنویسید...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                  IconButton(onPressed: send, icon: const Icon(Icons.send_rounded)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        Text('Discover', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        SizedBox(height: 18),
        Card(child: ListTile(leading: Icon(Icons.campaign), title: Text('Channels'), subtitle: Text('کانال‌های عمومی را پیدا کنید'))),
        Card(child: ListTile(leading: Icon(Icons.groups), title: Text('Groups'), subtitle: Text('گروه‌های جدید را پیدا کنید'))),
        Card(child: ListTile(leading: Icon(Icons.person_search), title: Text('People'), subtitle: Text('کاربران را با نام کاربری جست‌وجو کنید'))),
      ],
    );
  }
}

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Icon(Icons.star_rounded, size: 72),
        const SizedBox(height: 12),
        const Text('TEAM-CYB Premium',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('امکانات ویژهٔ حساب خود را فعال کنید.',
            textAlign: TextAlign.center),
        const SizedBox(height: 25),
        const Card(
          child: Column(
            children: [
              ListTile(leading: Icon(Icons.cloud_upload), title: Text('فضای بیشتر')),
              ListTile(leading: Icon(Icons.palette), title: Text('تم‌های ویژه')),
              ListTile(leading: Icon(Icons.bolt), title: Text('امکانات پیشرفته')),
            ],
          ),
        ),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: () {},
          child: const Padding(
            padding: EdgeInsets.all(14),
            child: Text('فعال‌سازی Premium'),
          ),
        ),
        OutlinedButton(
          onPressed: () {},
          child: const Text('انتقال Premium با کد'),
        ),
      ],
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(),
          accountName: Text('TEAM-CYB User'),
          accountEmail: Text('@username'),
          currentAccountPicture: CircleAvatar(child: Icon(Icons.person)),
        ),
        ListTile(leading: Icon(Icons.person_outline), title: Text('Profile')),
        ListTile(leading: Icon(Icons.notifications_none), title: Text('Notifications')),
        ListTile(leading: Icon(Icons.lock_outline), title: Text('Privacy & Security')),
        ListTile(leading: Icon(Icons.palette_outlined), title: Text('Appearance')),
        ListTile(leading: Icon(Icons.info_outline), title: Text('About TEAM-CYB')),
      ],
    );
  }
}
