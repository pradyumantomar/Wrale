import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wrale/core/icons.dart';
import 'package:wrale/core/notifier.dart';
import 'package:wrale/pages/about.dart';
import 'package:wrale/widget/icon_hero.dart';
import 'package:wrale/widget/route_transition.dart';

NavigationDrawer appDrawer(
  BuildContext context,
  Function(int) handlePageChanged,
  int selectedIndex,
) {
  final WraleNotifier wraleNotifier = Provider.of<WraleNotifier>(context);
  return NavigationDrawer(
      onDestinationSelected: handlePageChanged,
      selectedIndex: selectedIndex,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
              // borderRadius: BorderRadius.only(
              //   topRight: Radius.circular(4.0),
              // ),
              ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: IconHero(),
          ),
        ),
        ListTile(
          dense: true,
          leading: Icon(
            CustomIcons.account,
            color: Theme.of(context).iconTheme.color,
          ),
          title: TextFormField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration.collapsed(
                hintText: 'What is your name?',
                hintStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
              initialValue: wraleNotifier.userName,
              onChanged: (String value) {
                wraleNotifier.userName = value;
              }),
          onTap: () {},
        ),
        ListTile(
          dense: true,
          leading: Icon(
            CustomIcons.settings,
            color: Theme.of(context).iconTheme.color,
          ),
          title: AutoSizeText(
            'Setting',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
            maxLines: 1,
          ),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).push<dynamic>(SlideRoute(
              page: const About(),
              direction: TransitionDirection.left,
            ));
          },
        ),
        ListTile(
          dense: true,
          leading: Icon(
            CustomIcons.faq,
            color: Theme.of(context).iconTheme.color,
          ),
          title: AutoSizeText(
            'FAQ',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
            maxLines: 1,
          ),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).push<dynamic>(SlideRoute(
              page: const About(),
              direction: TransitionDirection.left,
            ));
          },
        ),
        ListTile(
          dense: true,
          leading: Icon(
            CustomIcons.info,
            color: Theme.of(context).iconTheme.color,
          ),
          title: AutoSizeText(
            'About Us',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
            maxLines: 1,
          ),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).push<dynamic>(SlideRoute(
              page: const About(),
              direction: TransitionDirection.left,
            ));
          },
        )
      ]);
}
