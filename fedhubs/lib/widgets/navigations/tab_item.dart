import 'package:flutter/material.dart';

enum TabItem { events, reservations, settings }

class TabItemData {
  const TabItemData({required this.label, required this.icon});

  final String label;
  final IconData icon;

  static const Map<TabItem, TabItemData> allTabs = {
    TabItem.events:
        TabItemData(label: 'Evenements', icon: Icons.event_available_outlined),
    TabItem.reservations:
        TabItemData(label: 'Réservations', icon: Icons.menu_book),
    TabItem.settings: TabItemData(label: 'Paramètres', icon: Icons.menu),
  };
}
