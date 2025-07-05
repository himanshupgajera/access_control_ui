import 'package:flutter/material.dart';
import 'package:access_control_ui/access_control_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AccessControlProvider(
      roles: ['admin'],
      permissions: ['dashboard.view', 'settings.edit'],
      plan: 'pro',
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Access Control UI Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Access Control Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Dashboard Access:'),
            const SizedBox(height: 8),

            AccessControl(
              requiredPermissions: ['dashboard.view'],
              fallback: const Text('⛔ You do not have dashboard access.'),
              child: const Text('✅ You can view the dashboard.'),
            ),

            const SizedBox(height: 24),
            const Text('Settings Button:'),
            const SizedBox(height: 8),

            AccessControl(
              requiredPermissions: ['settings.edit'],
              fallback: const Text('⛔ Access denied to edit settings.'),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Edit Settings'),
              ),
            ),

            const SizedBox(height: 24),
            const Text('Admin Only Section:'),
            const SizedBox(height: 8),

            AccessGuard(
              requiredRoles: ['admin'],
              fallback: const Text('⛔ This section is for admins only.'),
              child: Container(
                padding: const EdgeInsets.all(12),
                color: Colors.green[100],
                child: const Text('👑 Admin-exclusive content here.'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
