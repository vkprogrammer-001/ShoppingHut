import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_hut/core/theme/app_theme.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Theme Settings Section
          const SectionHeader(title: 'Appearance'),
          SettingsTile(
            title: 'Dark Mode',
            subtitle: 'Toggle between light and dark theme',
            trailing: Switch(
              value: themeProvider.isDarkMode,
              activeColor: Colors.teal,
              onChanged: (value) {
                themeProvider.toggleTheme();
              },
            ),
            onTap: () {
              themeProvider.toggleTheme();
            },
          ),
          
          const Divider(),
          
          // Account Section
          const SectionHeader(title: 'Account'),
          SettingsTile(
            title: 'Personal Information',
            subtitle: 'Manage your personal details',
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Navigate to personal information page
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Coming soon!')),
              );
            },
          ),
          SettingsTile(
            title: 'Address Book',
            subtitle: 'Manage your delivery addresses',
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Navigate to address book page
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Coming soon!')),
              );
            },
          ),
          
          const Divider(),
          
          // About Section
          const SectionHeader(title: 'About'),
          SettingsTile(
            title: 'App Version',
            subtitle: '1.0.0',
            onTap: () {},
          ),
          SettingsTile(
            title: 'Terms and Conditions',
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Navigate to terms page
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Coming soon!')),
              );
            },
          ),
          SettingsTile(
            title: 'Privacy Policy',
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Navigate to privacy policy page
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Coming soon!')),
              );
            },
          ),
        ],
      ),
    );
  }
}

// Section Header widget
class SectionHeader extends StatelessWidget {
  final String title;
  
  const SectionHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}

// Settings Tile widget
class SettingsTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback onTap;
  
  const SettingsTile({
    Key? key,
    required this.title,
    this.subtitle,
    this.trailing,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: trailing,
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
    );
  }
} 