import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_picsou/controllers/home/create_expense_controller.dart';
import 'package:projet_picsou/controllers/home/create_group_controller.dart';
import 'package:projet_picsou/controllers/me/edit_personal_data_controller.dart';
import 'package:projet_picsou/controllers/entry_point_controller.dart';
import 'package:projet_picsou/controllers/friends/friends_controller.dart';
import 'package:projet_picsou/controllers/home/home_controller.dart';
import 'package:projet_picsou/controllers/auth/login_controller.dart';
import 'package:projet_picsou/controllers/me/me_controller.dart';
import 'package:projet_picsou/controllers/friends/received_friend_request_controller.dart';
import 'package:projet_picsou/controllers/auth/register_controller.dart';
import 'package:projet_picsou/controllers/friends/search_user_with_email_controller.dart';
import 'package:projet_picsou/controllers/auth/select_profile_picture_controller.dart';
import 'package:projet_picsou/controllers/friends/sent_friend_request_controller.dart';
import 'package:projet_picsou/services/expense_service.dart';
import 'package:projet_picsou/services/group_service.dart';
import 'package:projet_picsou/services/session_service.dart';
import 'package:projet_picsou/services/friend_service.dart';
import 'package:projet_picsou/services/user_service.dart';
import 'package:projet_picsou/views/entry_point_view.dart';
import 'package:provider/provider.dart';

import 'controllers/me/edit_paiement_data_controller.dart';
import 'core/theme/app_theme.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // Couleur de fond de la barre d'état
    statusBarIconBrightness: Brightness.dark, // Pour des icônes noires sur fond clair
  ));

  final userService = UserService();
  final sessionService = SessionService();
  final friendService = FriendService();
  final groupService = GroupService();
  final expenseService = ExpenseService();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EntryPointController(userService)),
        ChangeNotifierProvider(create: (_) => HomeController(userService, groupService)),
        ChangeNotifierProvider(create: (_) => LoginController(sessionService)),
        ChangeNotifierProvider(create: (_) => RegisterController(userService)),
        ChangeNotifierProvider(create: (_) => MeController()),
        ChangeNotifierProvider(create: (_) => FriendsController(friendService)),
        ChangeNotifierProvider(create: (_) => EditPersonalDataController(userService)),
        ChangeNotifierProvider(create: (_) => SearchUserWithEmailController(userService, friendService)),
        ChangeNotifierProvider(create: (_) => SelectProfilePictureController(userService)),
        ChangeNotifierProvider(create: (_) => EditPaiementDataController(userService)),
        ChangeNotifierProvider(create: (_) => SentFriendRequestController(friendService)),
        ChangeNotifierProvider(create: (_) => ReceivedFriendRequestController(friendService)),
        ChangeNotifierProvider(create: (_) => CreateGroupController(userService, friendService, groupService)),
        ChangeNotifierProvider(create: (_) => CreateExpenseController(userService, friendService, groupService, expenseService)),
      ],
      child: MaterialApp(
        title: 'PICSOU',
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        navigatorKey: navigatorKey,
        home: EntryPointView(),
      )
    ),
  );
}


