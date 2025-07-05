// test/access_control_ui_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:access_control_ui/access_control_ui.dart';

void main() {
  group('AccessControl Widget', () {
    testWidgets('shows child when role matches', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AccessControlProvider(
            roles: ['admin'],
            permissions: [],
            child: AccessControl(
              requiredRoles: ['admin'],
              child: Text('Visible'),
            ),
          ),
        ),
      );
      expect(find.text('Visible'), findsOneWidget);
    });

    testWidgets('hides child when role does not match', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AccessControlProvider(
            roles: ['user'],
            permissions: [],
            child: AccessControl(
              requiredRoles: ['admin'],
              child: Text('Hidden'),
            ),
          ),
        ),
      );
      expect(find.text('Hidden'), findsNothing);
    });

    testWidgets('shows fallback when role does not match', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AccessControlProvider(
            roles: ['user'],
            permissions: [],
            child: AccessControl(
              requiredRoles: ['admin'],
              fallback: Text('Fallback'),
              child: Text('Hidden'),
            ),
          ),
        ),
      );
      expect(find.text('Fallback'), findsOneWidget);
    });
  });

  group('AccessControlProvider', () {
    testWidgets('provides role and permission access', (tester) async {
      late AccessControlProvider? provider;

      await tester.pumpWidget(
        Builder(
          builder: (context) {
            return AccessControlProvider(
              roles: ['editor'],
              permissions: ['edit.content'],
              child: Builder(
                builder: (innerContext) {
                  provider = AccessControlProvider.of(innerContext);
                  return Container();
                },
              ),
            );
          },
        ),
      );

      expect(provider?.hasRole('editor'), true);
      expect(provider?.hasPermission('edit.content'), true);
      expect(provider?.isOnPlan('pro'), false);
    });
  });
}
