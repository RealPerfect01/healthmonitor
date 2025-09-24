import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
      child: ExpansionTile(
        leading: const Icon(Icons.question_answer),
        title: Text('Frequently Asked Questions', style: Theme.of(context).textTheme.bodyLarge),
        children: <Widget>[
          ListTile(
            title: Text('How do I reset my password?', style: Theme.of(context).textTheme.bodyMedium),
            subtitle: Text('Go to Settings > Security > Change Password.', style: Theme.of(context).textTheme.bodySmall),
            onTap: () {},
          ),
          ListTile(
            title: Text('How do I change the theme?', style: Theme.of(context).textTheme.bodyMedium),
            subtitle: Text('Go to Settings > Theme and select your preferred theme.', style: Theme.of(context).textTheme.bodySmall),
            onTap: () {},
          ),
          ListTile(
            title: Text('How do I enable notifications?', style: Theme.of(context).textTheme.bodyMedium),
            subtitle: Text('Go to Settings > Notifications and toggle the switch.', style: Theme.of(context).textTheme.bodySmall),
            onTap: () {},
          ),
          ListTile(
            title: Text('How do I view a patient\'s details?', style: Theme.of(context).textTheme.bodyMedium),
            subtitle: Text('Tap on a patient\'s card in the patient list.', style: Theme.of(context).textTheme.bodySmall),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildContactSupport(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.contact_support),
            title: Text('Contact Support', style: Theme.of(context).textTheme.bodyLarge),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.email),
                onPressed: () => _launchURL('mailto:support@example.com'),
              ),
              IconButton(
                icon: const Icon(Icons.public), // Placeholder for a generic social media icon
                onPressed: () => _launchURL('https://x.com/flutterdev'),
              ),
              IconButton(
                icon: const Icon(Icons.facebook),
                onPressed: () => _launchURL('https://facebook.com/flutterdev'),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildReportBug(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.bug_report),
        title: Text('Report a Bug', style: Theme.of(context).textTheme.bodyLarge),
        onTap: () {
          _showFeedbackDialog(context, 'Report a Bug');
        },
      ),
    );
  }

  Widget _buildSendFeedback(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.feedback),
        title: Text('Send Feedback', style: Theme.of(context).textTheme.bodyLarge),
        onTap: () {
          _showFeedbackDialog(context, 'Send Feedback');
        },
      ),
    );
  }

  void _showFeedbackDialog(BuildContext context, String title) {
    final formKey = GlobalKey<FormState>();
    final feedbackController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Form(
            key: formKey,
            child: TextFormField(
              controller: feedbackController,
              decoration: const InputDecoration(labelText: 'Your feedback'),
              maxLines: 5,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your feedback';
                }
                return null;
              },
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
                  // Implement feedback submission logic here
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Thank you for your feedback!')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }
}
