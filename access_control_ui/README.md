# access_control_ui

A Flutter package for managing **UI visibility and screen access** based on **roles**, **permissions**, and **plans**.

## Features

- ✅ Widget-level access control (`AccessControl`)
- ✅ Screen-level guards (`AccessGuard`)
- ✅ Global context (`AccessControlProvider`)
- ✅ Utility methods for quick access checks

## Installation

```yaml
dependencies:
  access_control_ui: ^1.0.0
```

## Usage

Wrap your app with:

```dart
AccessControlProvider(
  roles: ['admin'],
  permissions: ['dashboard.view'],
  plan: 'pro',
  child: MyApp(),
);
```

Restrict widgets:

```dart
AccessControl(
  requiredPermissions: ['user.create'],
  child: ElevatedButton(onPressed: () {}, child: Text('Create User')),
);
```

## License

MIT