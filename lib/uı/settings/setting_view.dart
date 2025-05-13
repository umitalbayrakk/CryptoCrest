import 'package:flutter/material.dart';
import 'package:flutter_cryptocrest_app/core/utils/color.dart';
import 'package:flutter_cryptocrest_app/widgets/appbar/abbar_widgets.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  String _selectedTheme = 'Açık';
  String _selectedLanguage = 'Türkçe';
  final List<String> _themes = ['Açık', 'Koyu', 'Sistem'];
  final List<String> _languages = ['Türkçe', 'İngilizce', 'Almanca'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: AppBarWidgets(),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SwitchListTile(
            title: const Text('Bildirimler'),
            subtitle: const Text('Bildirimleri aç veya kapat'),
            value: _notificationsEnabled,
            onChanged: (bool value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
            activeColor: AppColors.appBarColor,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              title: const Text('Tema'),
              subtitle: Text('Geçerli tema: $_selectedTheme'),
              onTap: () {
                showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: const Text('Tema Seç'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children:
                              _themes
                                  .map(
                                    (theme) => RadioListTile<String>(
                                      title: Text(theme),
                                      value: theme,
                                      groupValue: _selectedTheme,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedTheme = value!;
                                        });
                                        Navigator.pop(context);
                                      },
                                    ),
                                  )
                                  .toList(),
                        ),
                        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('İptal'))],
                      ),
                );
              },
            ),
          ),
          ListTile(
            title: const Text('Dil'),
            subtitle: Text('Geçerli dil: $_selectedLanguage'),
            onTap: () {
              showDialog(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: const Text('Dil Seç'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children:
                            _languages
                                .map(
                                  (language) => RadioListTile<String>(
                                    title: Text(language),
                                    value: language,
                                    groupValue: _selectedLanguage,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedLanguage = value!;
                                      });
                                      Navigator.pop(context);
                                    },
                                  ),
                                )
                                .toList(),
                      ),
                      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('İptal'))],
                    ),
              );
            },
          ),
          ListTile(title: const Text('Paket Version'), subtitle: const Text('Uygulama sürümü: 1.0.0')),
        ],
      ),
    );
  }
}
