import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
      elevation: 4,
      child: ListTile(
        leading: const Icon(Icons.person),
        title: const Text('Profile Settings'),
        onTap: () {
          // Navigate to profile settings page
        },
      ),
    );
  }

  Widget _buildNotificationPreferences(BuildContext context) {
    return Card(
      elevation: 4,
      child: SwitchListTile(
        secondary: const Icon(Icons.notifications),
        title: const Text('Enable Notifications'),
        value: true, // Replace with actual notification preference
        onChanged: (bool value) {
          // Handle notification preference change
        },
      ),
    );
  }

  Widget _buildThemeSettings(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Theme', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ListTile(
              title: const Text('Light Mode'),
              leading: Radio<ThemeMode>(
                value: ThemeMode.light,
                groupValue: themeProvider.themeMode,
                onChanged: (ThemeMode? value) {
                  if (value != null) {
                    themeProvider.setThemeMode(value);
                  }
                },
              ),
              onTap: () => themeProvider.setThemeMode(ThemeMode.light),
            ),
            ListTile(
              title: const Text('Dark Mode'),
              leading: Radio<ThemeMode>(
                value: ThemeMode.dark,
                groupValue: themeProvider.themeMode,
                onChanged: (ThemeMode? value) {
                  if (value != null) {
                    themeProvider.setThemeMode(value);
                  }
                },
              ),
              onTap: () => themeProvider.setThemeMode(ThemeMode.dark),
            ),
            ListTile(
              title: const Text('System Default'),
              leading: Radio<ThemeMode>(
                value: ThemeMode.system,
                groupValue: themeProvider.themeMode,
                onChanged: (ThemeMode? value) {
                  if (value != null) {
                    themeProvider.setThemeMode(value);
                  }
                },
              ),
              onTap: () => themeProvider.setThemeMode(ThemeMode.system),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecuritySettings(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Change Password'),
            onTap: () {
              // Navigate to change password page
            },
          ),
          ListTile(
            leading: const Icon(Icons.security),
            title: const Text('Enable 2-Factor Authentication'),
            onTap: () {
              // Navigate to 2FA page
            },
          ),
        ],
      ),
    );
  }
}
