import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/theme_provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildProfileSettings(context),
            const SizedBox(height: 24),
            _buildNotificationPreferences(context),
            const SizedBox(height: 24),
            _buildThemeSettings(context),
            const SizedBox(height: 24),
            _buildSecuritySettings(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSettings(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.person),
        title: Text('Profile Settings', style: Theme.of(context).textTheme.bodyLarge),
        onTap: () {
          // Navigate to profile settings page
        },
      ),
    );
  }

  Widget _buildNotificationPreferences(BuildContext context) {
    return Card(
      child: SwitchListTile(
        secondary: const Icon(Icons.notifications),
        title: Text('Enable Notifications', style: Theme.of(context).textTheme.bodyLarge),
        value: _notificationsEnabled, // Replace with actual notification preference
        onChanged: (bool value) {
          setState(() {
            _notificationsEnabled = value;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Notifications ${value ? 'enabled' : 'disabled'}')),
          );
        },
      ),
    );
  }

  Widget _buildThemeSettings(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Theme', style: Theme.of(context).textTheme.displaySmall),
            const SizedBox(height: 16),
            ToggleButtons(
              isSelected: [
                themeProvider.themeMode == ThemeMode.light,
                themeProvider.themeMode == ThemeMode.dark,
                themeProvider.themeMode == ThemeMode.system,
              ],
              onPressed: (int index) {
                if (index == 0) {
                  themeProvider.setThemeMode(ThemeMode.light);
                } else if (index == 1) {
                  themeProvider.setThemeMode(ThemeMode.dark);
                } else {
                  themeProvider.setThemeMode(ThemeMode.system);
                }
              },
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('Light'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('Dark'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('System'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecuritySettings(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.lock),
            title: Text('Change Password', style: Theme.of(context).textTheme.bodyLarge),
            onTap: () {
              _showChangePasswordDialog(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.security),
            title: Text('Enable 2-Factor Authentication', style: Theme.of(context).textTheme.bodyLarge),
            onTap: () {
              // Navigate to 2FA page
            },
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Change Password'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: currentPasswordController,
                  decoration: const InputDecoration(labelText: 'Current Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your current password';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: newPasswordController,
                  decoration: const InputDecoration(labelText: 'New Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a new password';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: confirmPasswordController,
                  decoration: const InputDecoration(labelText: 'Confirm New Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your new password';
                    }
                    if (value != newPasswordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  // Implement password change logic here
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Password changed successfully')),
                  );
                }
              },
              child: const Text('Change'),
            ),
          ],
        );
      },
    );
  }
}
