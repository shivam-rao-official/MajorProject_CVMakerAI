import 'package:cvmaker_app_sarah_proj/UserDataStorage.dart';
import 'package:cvmaker_app_sarah_proj/screens/view_cv.dart';
import 'package:cvmaker_app_sarah_proj/services/api_services/CVService.dart';
import 'package:cvmaker_app_sarah_proj/widgets/appbar.dart';
import 'package:cvmaker_app_sarah_proj/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var userService = Get.put(UserDataStorage());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    return await CVService().fetchCV();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(61),
            child: CustomAppbar(
              appBarLabel: "CV Maker",
              isActionBtnRequired: true,
            ),
          ),
          drawer: CustomDrawer(),
          body: FutureBuilder(
            future: loadData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                const Center(child: CircularProgressIndicator());
              if (!snapshot.hasData) {
                const Center(
                  child: Text("No CV Found"),
                );
              }
              return ListView.builder(
                itemCount: (snapshot.data as List).length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      tileColor: Colors.blue.shade50,
                      title: Text((snapshot.data! as List)[index]["cvName"]),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ViewCVScreen(
                           cvId: (snapshot.data! as List)[index]["cvId"],
                          ),
                        ));
                      },
                    ),
                  );
                },
              );
            },
          )),
    );
  }
}
