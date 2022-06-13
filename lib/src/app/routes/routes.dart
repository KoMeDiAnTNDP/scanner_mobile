import 'package:flutter/widgets.dart';

import 'package:scanner_mobile/src/home/home.dart';
import 'package:scanner_mobile/src/auth/auth_page.dart';
import 'package:scanner_mobile/src/app/bloc/app_bloc.dart';

List<Page> onGenerateAppViewPages(AppStatus status, List<Page<dynamic>> pages) {
  switch (status) {
    case AppStatus.authenticated:
      return [HomeFlow.page()];
    case AppStatus.unauthenticated:
      return [AuthorizationPage.page()];
  }
}
