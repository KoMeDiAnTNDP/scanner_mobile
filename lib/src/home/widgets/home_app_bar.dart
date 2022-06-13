import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:scanner_mobile/src/app/bloc/app_bloc.dart';
import 'package:scanner_mobile/src/home/bloc/home_bloc.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = context.read<AppBloc>();

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return AppBar(
          title: RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 20.0),
              children: [
                const TextSpan(text: 'Welcome, '),
                state.userIsLoading
                    ? const WidgetSpan(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 5.0),
                    child: SizedBox(
                      width: 15.0,
                      height: 15.0,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.0,
                      ),
                    ),
                  ),
                )
                    : TextSpan(text: state.user.username),
              ],
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => appBloc.add(AppLogoutRequested()),
              icon: const Icon(Icons.logout),
            ),
          ],
        );
      },
    );
  }
}