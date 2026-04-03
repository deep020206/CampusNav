import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _voiceGuidanceEnabled = true;
  bool _offlineMapsEnabled = true;
  double _speechRate = 0.5;
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Navigation Settings
            _buildSectionHeader('Navigation'),
            _buildSwitchTile(
              title: 'Voice Guidance',
              subtitle: 'Enable voice-guided directions',
              value: _voiceGuidanceEnabled,
              onChanged: (value) {
                setState(() {
                  _voiceGuidanceEnabled = value;
                });
              },
            ),
            _buildSwitchTile(
              title: 'Offline Maps',
              subtitle: 'Cache maps for offline access',
              value: _offlineMapsEnabled,
              onChanged: (value) {
                setState(() {
                  _offlineMapsEnabled = value;
                });
              },
            ),
            const Divider(),
            
            // Voice Settings
            _buildSectionHeader('Voice Settings'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Speech Rate',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${(_speechRate * 100).toStringAsFixed(0)}%',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Slider(
                    value: _speechRate,
                    onChanged: (value) {
                      setState(() {
                        _speechRate = value;
                      });
                    },
                    min: 0.3,
                    max: 1.0,
                    divisions: 7,
                    activeColor: Colors.deepPurple,
                  ),
                ],
              ),
            ),
            const Divider(),

            // Language Settings
            _buildSectionHeader('Language & Region'),
            _buildDropdownTile(
              title: 'Language',
              value: _selectedLanguage,
              items: const ['English', 'Spanish', 'French', 'German'],
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value ?? 'English';
                });
              },
            ),
            const Divider(),

            // About and Support
            _buildSectionHeader('About'),
            _buildInfoTile(
              title: 'App Version',
              subtitle: '1.0.0',
            ),
            _buildInfoTile(
              title: 'Flutter Version',
              subtitle: '3.8.0+',
            ),
            ListTile(
              title: const Text('Help & Support'),
              subtitle: const Text('Get help using the app'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Show help dialog or navigate to help page
                _showHelpDialog(context);
              },
            ),
            ListTile(
              title: const Text('Privacy Policy'),
              subtitle: const Text('View our privacy policy'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Show privacy policy
              },
            ),
            ListTile(
              title: const Text('Terms & Conditions'),
              subtitle: const Text('Read terms and conditions'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Show terms and conditions
              },
            ),
            const Divider(),

            // Clear Cache
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    _showClearCacheDialog(context);
                  },
                  icon: const Icon(Icons.delete_outline),
                  label: const Text('Clear Cache'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.deepPurple,
      ),
    );
  }

  Widget _buildDropdownTile({
    required String title,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          DropdownButton<String>(
            value: value,
            items: items
                .map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    ))
                .toList(),
            onChanged: onChanged,
            underline: Container(),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile({
    required String title,
    required String subtitle,
  }) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Help & Support'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'How to use Campus Navigation:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text('1. Search for a location using the search bar'),
              Text('2. Tap on a location to view details'),
              Text('3. Select start and end points for navigation'),
              Text('4. Follow the step-by-step directions'),
              Text('5. Enable voice guidance for audio instructions'),
              SizedBox(height: 12),
              Text(
                'For more help, contact support.',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showClearCacheDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Cache?'),
        content: const Text(
          'This will remove all cached maps and data. You can re-download them when needed.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Clear cache logic here
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cache cleared')),
              );
            },
            child: const Text('Clear', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
