import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:stockpilot_app/main.dart';
import 'package:stockpilot_app/views/home/homeWidget.dart';
import 'package:stockpilot_app/views/notification/notifHome.dart';
import 'package:stockpilot_app/views/root/root_bloc.dart';
import 'package:stockpilot_app/views/web/webPage.dart';
import 'package:stockpilot_app/widgets/loader.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {

  testWidgets('Initially displays the web Page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MultiBlocProvider(
            providers: [
              BlocProvider<RootBloc>(
                create: (context) => RootBloc(context),
              ),
            ],
          child: MaterialApp(
              home: HomeWidget()
            )
          ));


    await tester.pump();
    // // Verify
    final web = find.byType(WebView);
    expect(web, findsOneWidget);
  });

  // testWidgets('Navigation displays Notification Page', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(MultiBlocProvider(
  //       providers: [
  //         BlocProvider<RootBloc>(
  //           create: (context) => RootBloc(context),
  //         ),
  //       ],
  //       child: MaterialApp(
  //           home: HomeWidget()
  //       )
  //   ));
  //
  //   final bottomNavigationBar = find.byType(BottomNavigationBar);
  //
  //   await tester.tap(bottomNavigationBar);
  //   await tester.pumpAndSettle(const Duration(seconds: 5));
  //   // // debugDumpApp();
  //   // // Verify
  //   final notifPage = find.byType(NotifHome);
  //   expect(notifPage, findsOneWidget);
  // });
}

