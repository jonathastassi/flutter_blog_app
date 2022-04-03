import 'package:flutter/material.dart';
import 'package:flutter_blog_app/src/app/bloc/app_cubit.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabs = [
      const Tab(
        icon: Icon(Icons.home),
        text: 'Feed',
      ),
      const Tab(
        icon: Icon(Icons.newspaper),
        text: 'Novidades',
      )
    ];

    final pages = [
      Center(
        child: Text('Feed'),
      ),
      Center(
        child: Text('Novidades'),
      ),
    ];

    final AppCubit cubit = Modular.get();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          actions: [
            IconButton(
              onPressed: cubit.logout,
              icon: const Icon(
                Icons.logout,
              ),
            )
          ],
        ),
        body: TabBarView(
          children: pages,
        ),
        bottomNavigationBar: Material(
          elevation: 0,
          color: Theme.of(context).colorScheme.primary,
          child: TabBar(
            indicatorColor: Theme.of(context).colorScheme.onPrimary,
            tabs: tabs,
          ),
        ),
      ),
    );
  }
}
