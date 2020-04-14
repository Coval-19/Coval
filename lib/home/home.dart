import 'package:coval/home/main_page.dart';
import 'package:coval/models/business_data.dart';
import 'package:coval/models/business_visit.dart';
import 'package:coval/models/user.dart';
import 'package:coval/models/user_data.dart';
import 'package:coval/services/businesses_data_service.dart';
import 'package:coval/services/user_data_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final BusinessesDataService _businessesDataService = BusinessesDataService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final userDatabaseService = UserDatabaseService(uid: user.uid);
    return MultiProvider(providers: [
      StreamProvider<UserData>.value(value: userDatabaseService.userData),
      StreamProvider<List<BusinessData>>.value(
          initialData: [], value: _businessesDataService.streamBusinesses()),
      StreamProvider<List<BusinessVisit>>.value(
          initialData: [], value: userDatabaseService.userVisits)
    ], child: MainPage());
  }
}
