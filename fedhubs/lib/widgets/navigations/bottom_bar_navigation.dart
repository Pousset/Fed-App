import 'package:fedhubs_pro/animations/bottom_bar_page_transition.dart';
import 'package:fedhubs_pro/widgets/navigations/panel_provider.dart';
import 'package:fedhubs_pro/widgets/navigations/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class BottomBarNavigation extends StatefulWidget {
  const BottomBarNavigation(
      {Key? key,
      required this.currentPage,
      required this.tabs,
      required this.page,
      required this.panelController})
      : assert(tabs.length == page.length),
        assert(currentPage < page.length),
        super(key: key);
  final int currentPage;
  final List<TabItem> tabs;
  final List<Widget> page;
  final PanelController panelController;

  @override
  State<BottomBarNavigation> createState() => _BottomBarNavigationState();
}

class _BottomBarNavigationState extends State<BottomBarNavigation> {
  @override
  Widget build(BuildContext context) {
    final panel = Provider.of<PanelProvider>(context);

    return SlidingUpPanel(
      controller: widget.panelController,
      header: panel.header,
      panel: panel.panel,
      minHeight: panel.minHeight,
      maxHeight: panel.maxHeight,
      backdropEnabled: panel.backdropEnabled,
      backdropOpacity: panel.backdropOpacity,
      borderRadius: panel.borderRadius,
      body: Scaffold(
        body: BottomBarPageTransition(
          builder: (context, index) => widget.page[index],
          currentIndex: widget.currentPage,
          totalLength: widget.tabs.length,
        ),
        extendBody: true,
        bottomNavigationBar: _getBottomBar(),
      ),
    );
  }

  Widget _getBottomBar() {
    return Material(
      color: Colors.white,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      elevation: 8.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: widget.currentPage,
          onTap: (index) {
            context.go('/${widget.tabs[index].name}');
            setState(() {});
          },
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
          selectedItemColor:
              BottomNavigationBarTheme.of(context).selectedLabelStyle!.color,
          unselectedItemColor:
              BottomNavigationBarTheme.of(context).unselectedLabelStyle!.color,
          type: BottomNavigationBarType.fixed,
          items: List.generate(
            widget.tabs.length,
            (index) {
              final tab = TabItemData.allTabs[widget.tabs[index]]!;
              return BottomNavigationBarItem(
                icon: Icon(tab.icon),
                label: tab.label,
              );
            },
          ),
        ),
      ),
    );
  }
}
