/// A model representing access-related data for a user, such as roles,
/// permissions, and subscription plan.
///
/// This model is useful when decoding access info from an API or database,
/// and passing it into the [AccessControlProvider].
class AccessControlModel {
  /// A list of roles assigned to the user.
  final List<String> roles;

  /// A list of permissions available to the user.
  final List<String> permissions;

  /// Optional subscription plan assigned to the user (e.g. 'free', 'pro').
  final String? plan;

  /// Creates an [AccessControlModel] instance.
  AccessControlModel({
    required this.roles,
    required this.permissions,
    this.plan,
  });

  /// Creates an [AccessControlModel] from a JSON object.
  ///
  /// Example:
  /// ```json
  /// {
  ///   "roles": ["admin"],
  ///   "permissions": ["dashboard.view"],
  ///   "plan": "pro"
  /// }
  /// ```
  factory AccessControlModel.fromJson(Map<String, dynamic> json) {
    return AccessControlModel(
      roles: List<String>.from(json['roles'] ?? []),
      permissions: List<String>.from(json['permissions'] ?? []),
      plan: json['plan'],
    );
  }

  /// Converts the [AccessControlModel] to a JSON map.
  Map<String, dynamic> toJson() {
    return {'roles': roles, 'permissions': permissions, 'plan': plan};
  }
}
