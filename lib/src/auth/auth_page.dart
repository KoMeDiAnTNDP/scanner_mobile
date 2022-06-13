import 'package:flutter/material.dart';

import 'package:scanner_mobile/src/auth/login/login.dart';
import 'package:scanner_mobile/src/auth/sign_up/signup.dart';
import 'package:scanner_mobile/src/shared/repository/authorization/authorization_repository.dart';

const Key signInKey = Key('sign_in');
const Key signUpKey = Key('sign_up');
const List<Tab> tabs = <Tab>[
  Tab(key: signInKey, text: 'Sign In'),
  Tab(key: signUpKey, text: 'Sign Up')
];

class AuthorizationPage extends StatelessWidget {
  const AuthorizationPage({Key? key}): super(key: key);

  static Page page() => const MaterialPage(child: AuthorizationPage());

  @override
  Widget build(BuildContext context) {
    AuthorizationRepository authorizationRepository = AuthorizationRepository();

    return DefaultTabController(
      length: tabs.length,
      child: Builder(
        builder: (context) {
          final tabController = DefaultTabController.of(context)!;
          
          tabController.addListener(() {
            if (tabController.indexIsChanging) {

              ScaffoldMessenger.of(context).clearSnackBars();
            }
          });

          return Scaffold(
            key: const Key('authorization_page'),
            appBar: AppBar(
              title: const Text('Authorization'),
              bottom: const TabBar(tabs: tabs),
            ),
            body: TabBarView(
              children: tabs.map((Tab tab) {
                if (tab.key == signInKey) {
                  return Login(
                    authorizationRepository: authorizationRepository,
                  );
                }

                if (tab.key == signUpKey) {
                  return Signup(
                    authorizationRepository: authorizationRepository,
                  );
                }

                return const Center(child: Text('Tab'));
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}