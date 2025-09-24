
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HelpCenterPage extends StatefulWidget {
  const HelpCenterPage({super.key});

  @override
  State<HelpCenterPage> createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage> {
  String _version = '...';

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _version = info.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help Center'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          _buildSectionTitle('Frequently Asked Questions'),
          _buildExpansionTile('How do I reset my password?', 'You can reset your password from the profile settings page.'),
          _buildExpansionTile('How do I update my profile?', 'You can update your profile information from the profile settings page.'),
          _buildExpansionTile('Where can I see the patient list?', 'The patient list is available on the main dashboard after you log in.'),
          const Divider(),
          _buildSectionTitle('About App'),
          _buildListTile('App Version', _version),
          const Divider(),
          _buildSectionTitle('Contact Us'),
          _buildListTile('Email', 'support@example.com'),
          _buildListTile('Phone', '+1 234 567 890'),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Widget _buildExpansionTile(String title, String content) {
    return Card(
      child: ExpansionTile(
        title: Text(title),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(content),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(String title, String subtitle) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}
