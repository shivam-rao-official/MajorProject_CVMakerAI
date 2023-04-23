import 'package:cvmaker_app_sarah_proj/widgets/appbar.dart';
import 'package:cvmaker_app_sarah_proj/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(61),
          child: CustomAppbar(
            appBarLabel: "CV Maker",
            isActionBtnRequired: true,
          ),
        ),
        drawer: CustomDrawer(),
        body: Center(
          child: Text("No CV created yet.."),
        )
      ),
    );
  }
}
