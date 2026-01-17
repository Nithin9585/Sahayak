import 'package:flutter/material.dart';
import '../services/locale_service.dart';
import 'offline_manager_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(AppStrings.get('profile_title')),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    child: Text(
                      'TR',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppStrings.get('teacher_name'),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppStrings.get('school_name'),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatItem(context, '24', AppStrings.get('nav_students')),
                      _buildStatItem(context, '12', AppStrings.get('nav_activities')),
                      _buildStatItem(context, '4.8', 'Rating'),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),

            // Settings Sections
            _buildSectionHeader(AppStrings.get('section_sync')),
            _buildSettingsTile(
              context,
              icon: Icons.sync_rounded,
              title: 'Sync Status',
              subtitle: 'Last synced: Just now',
              trailing: const Icon(Icons.check_circle_rounded, color: Colors.green),
            ),
            _buildSettingsTile(
              context,
              icon: Icons.download_for_offline_rounded,
              title: 'Offline Content',
              subtitle: '124 MB used',
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OfflineManagerScreen()),
                );
              },
            ),

            _buildSectionHeader(AppStrings.get('section_prefs')),
            _buildSettingsTile(
              context,
              icon: Icons.language_rounded,
              title: AppStrings.get('lang_title'),
              subtitle: AppStrings.get('lang_subtitle'),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () => _showLanguageDialog(context),
            ),
            _buildSettingsTile(
              context,
              icon: Icons.notifications_rounded,
              title: 'Notifications',
              subtitle: 'Daily reminders on',
              trailing: Switch(value: true, onChanged: (_) {}),
            ),

            _buildSectionHeader(AppStrings.get('section_support')),
            _buildSettingsTile(
              context,
              icon: Icons.help_outline_rounded,
              title: 'Help & Tutorials',
              subtitle: 'Learn how to use Sahayak',
              trailing: const Icon(Icons.open_in_new_rounded),
            ),
             _buildSettingsTile(
              context,
              icon: Icons.info_outline_rounded,
              title: 'About Sahayak',
              subtitle: 'Version 1.0.0 (Beta)',
              trailing: const SizedBox(),
            ),
            
            const SizedBox(height: 48),
            
            TextButton(
              onPressed: () {},
              child: Text(
                AppStrings.get('logout'),
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppStrings.get('lang_title')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('English'),
                leading: Radio<String>(
                  value: 'en',
                  groupValue: appLocaleNotifier.value.languageCode,
                  onChanged: (value) {
                    appLocaleNotifier.value = const Locale('en');
                    Navigator.pop(context);
                  },
                ),
                onTap: () {
                  appLocaleNotifier.value = const Locale('en');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('ಕನ್ನಡ (Kannada)'),
                leading: Radio<String>(
                  value: 'kn',
                  groupValue: appLocaleNotifier.value.languageCode,
                  onChanged: (value) {
                    appLocaleNotifier.value = const Locale('kn');
                    Navigator.pop(context);
                  },
                ),
                onTap: () {
                  appLocaleNotifier.value = const Locale('kn');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatItem(BuildContext context, String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
            letterSpacing: 1.0,
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 1), // Divider effect
      child: ListTile(
        leading: Icon(icon, color: Colors.grey[600]),
        title: Text(title),
        subtitle: Text(
          subtitle,
          style: TextStyle(fontSize: 12, color: Colors.grey[500]),
        ),
        trailing: trailing,
        onTap: onTap ?? () {},
      ),
    );
  }
}
