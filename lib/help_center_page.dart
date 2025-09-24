import 'package:flutter/material.dart';

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help Center'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildFAQ(context),
            const SizedBox(height: 24),
            _buildContactSupport(context),
            const SizedBox(height: 24),
            _buildReportBug(context),
            const SizedBox(height: 24),
            _buildSendFeedback(context),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQ(BuildContext context) {
    return Card(
      elevation: 4,
      child: ExpansionTile(
        leading: const Icon(Icons.question_answer),
        title: const Text('Frequently Asked Questions'),
        children: <Widget>[
          ListTile(
            title: const Text('How do I reset my password?'),
            subtitle: const Text('Go to Settings > Security > Change Password.'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('How do I change the theme?'),
            subtitle: const Text('Go to Settings > Theme and select your preferred theme.'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildContactSupport(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        leading: const Icon(Icons.contact_support),
        title: const Text('Contact Support'),
        onTap: () {
          // Handle contact support action
        },
      ),
    );
  }

  Widget _buildReportBug(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        leading: const Icon(Icons.bug_report),
        title: const Text('Report a Bug'),
        onTap: () {
          // Handle report a bug action
        },
      ),
    );
  }

  Widget _buildSendFeedback(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        leading: const Icon(Icons.feedback),
        title: const Text('Send Feedback'),
        onTap: () {
          // Handle send feedback action
        },
      ),
    );
  }
}
