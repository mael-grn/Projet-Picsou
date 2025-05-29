import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_picsou/controllers/create_group_controller.dart';
import 'package:projet_picsou/controllers/edit_personal_data_controller.dart';
import 'package:projet_picsou/controllers/entry_point_controller.dart';
import 'package:projet_picsou/controllers/friends_controller.dart';
import 'package:projet_picsou/controllers/home_controller.dart';
import 'package:projet_picsou/controllers/login_controller.dart';
import 'package:projet_picsou/controllers/me_controller.dart';
import 'package:projet_picsou/controllers/received_friend_request_controller.dart';
import 'package:projet_picsou/controllers/register_controller.dart';
import 'package:projet_picsou/controllers/search_user_with_email_controller.dart';
import 'package:projet_picsou/controllers/select_profile_picture_controller.dart';
import 'package:projet_picsou/controllers/sent_friend_request_controller.dart';
import 'package:projet_picsou/services/group_service.dart';
import 'package:projet_picsou/services/session_service.dart';
import 'package:projet_picsou/services/friend_service.dart';
import 'package:projet_picsou/services/user_service.dart';
import 'package:projet_picsou/views/entry_point_view.dart';
import 'package:provider/provider.dart';

import 'controllers/edit_paiement_data_controller.dart';
import 'controllers/friend_widget_controller.dart';
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
        ChangeNotifierProvider(create: (_) => FriendWidgetController(friendService)),
        ChangeNotifierProvider(create: (_) => CreateGroupController(userService, friendService, groupService)),
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


