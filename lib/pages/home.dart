import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wrale/core/icons.dart';
import 'package:wrale/pages/overview.dart';
import 'package:wrale/pages/statsScreen.dart';
import 'package:wrale/widget/app_drawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> key = GlobalKey();
  final Duration animationDuration = const Duration(milliseconds: 500);
  bool popupShown = false;
  late bool loadedFirst;
  final double minHeight = 45.0;

  @override
  void initState() {
    super.initState();
    loadedFirst = true;
    _pageIndex = 0;

    _selectedTab = TabController(
      vsync: this,
      length: 2,
      initialIndex: _selectedIndex,
    );
    _selectedTab.addListener(_onSlideTab);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadedFirst) {
        loadedFirst = false;
        setState(() {});
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        /// default values of flutter definition
        /// https://github.com/flutter/flutter/blob/ee4e09cce01d6f2d7f4baebd247fde02e5008851/packages/flutter/lib/src/material/navigation_bar.dart#L1237
        systemNavigationBarColor: ElevationOverlay.colorWithOverlay(
          Theme.of(context).colorScheme.surface,
          Theme.of(context).colorScheme.primary,
          3.0,
        ),
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Theme.of(context).brightness,
      ),
    );
  }

  /// starts home with category all
  static int _selectedIndex = 0;
  // controller for selected category
  late TabController _selectedTab;
  //scrolling controller
  final ScrollController _scrollController = ScrollController();
  // active page
  static int _pageIndex = 0;

  void _onItemTapped(int index) {
    if (index == _selectedTab.length) {
      onFABpress();
    } else {
      _selectedIndex = index;
      _selectedTab.index = _selectedIndex;
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutExpo,
      );
      setState(() {});
    }
  }

  void _onSlideTab() {
    _onItemTapped(_selectedTab.index);
  }

  Future<void> onFABpress() async {
    setState(() {
      popupShown = true;
    });
  }

  void handlePageChanged(int selectedPage) {
    setState(() {
      _pageIndex = _selectedIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool showFAB = !popupShown;
    final List<Widget> activeTabs = <Widget>[
      const OverViewScreen(),
      const StatsScreen(),
    ];

    return Scaffold(
      key: key,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.home), label: 'home'),
          NavigationDestination(icon: Icon(Icons.event), label: 'achievements'),
          NavigationDestination(icon: SizedBox.shrink(), label: ''),
        ],
      ),
      body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool _) {
            return <Widget>[
              SliverAppBar(
                leading: IconButton(
                    onPressed: () => key.currentState!.openDrawer(),
                    icon: const Icon(CustomIcons.settings)),
              ),
            ];
          },
          body: TabBarView(
            controller: _selectedTab,
            children: activeTabs,
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: onFABpress,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      drawer: appDrawer(context, (p0) => null, _pageIndex),
    );
  }
}
