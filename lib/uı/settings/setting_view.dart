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
            title: Text(
              'Bildirimler',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.whiteColor),
            ),
            subtitle: Text(
              'Bildirimleri aç veya kapat',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.whiteColor),
            ),
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
              title: Text('Tema', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.whiteColor)),
              subtitle: Text(
                'Geçerli tema: $_selectedTheme',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.whiteColor),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: Text(
                          'Tema Seç',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.whiteColor),
                        ),
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
            title: Text('Dil', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.whiteColor)),
            subtitle: Text(
              'Geçerli dil: $_selectedLanguage',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.whiteColor),
            ),
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
          ListTile(
            title: Text(
              'Paket Version',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.whiteColor),
            ),
            subtitle: Text(
              'Uygulama sürümü: 1.0.0',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.whiteColor),
            ),
          ),
        ],
      ),
    );
  }
}
