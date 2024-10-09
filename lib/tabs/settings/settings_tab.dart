import 'package:flutter/material.dart';
import 'package:islami/app_theme.dart';
import 'package:islami/tabs/settings/language.dart';
import 'package:islami/tabs/settings/settings_provider.dart';
import 'package:provider/provider.dart';

class SettingsTab extends StatefulWidget {
  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  List<Language> languages = [
    Language(name: 'English', code: 'en'),
    Language(name: 'العربية', code: 'ar'),
  ];

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Dark Theme',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
              Switch(
                value: settingsProvider.isDark,
                onChanged: (isDark) => settingsProvider
                    .changeTheme(isDark ? ThemeMode.dark : ThemeMode.light),
                activeTrackColor: AppTheme.gold,
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Language',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
              DropdownButtonHideUnderline(
                child: DropdownButton<Language>(
                  value: languages.firstWhere((language) =>
                      language.code == settingsProvider.languageCode),
                  items: languages
                      .map(
                        (language) => DropdownMenuItem<Language>(
                          value: language,
                          child: Text(
                            language.name,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (selectedLanguage) {
                    if (selectedLanguage != null) {
                      settingsProvider.changeLanguage(selectedLanguage.code);
                    }
                  },
                  borderRadius: BorderRadius.circular(20),
                  dropdownColor: settingsProvider.isDark
                      ? AppTheme.darkPrimary
                      : AppTheme.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
