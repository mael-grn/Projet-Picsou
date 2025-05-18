import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_picsou/controllers/conversation_list_controller.dart';
import 'package:projet_picsou/controllers/edit_personal_data_controller.dart';
import 'package:projet_picsou/controllers/entry_point_controller.dart';
import 'package:projet_picsou/controllers/friend_conversation_controller.dart';
import 'package:projet_picsou/controllers/home_controller.dart';
import 'package:projet_picsou/controllers/login_controller.dart';
import 'package:projet_picsou/controllers/me_controller.dart';
import 'package:projet_picsou/controllers/register_controller.dart';
import 'package:projet_picsou/services/auth_service.dart';
import 'package:projet_picsou/services/friend_service.dart';
import 'package:projet_picsou/services/group_service.dart';
import 'package:projet_picsou/services/user_service.dart';
import 'package:projet_picsou/views/entry_point_view.dart';
import 'package:provider/provider.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // Couleur de fond de la barre d'état
    statusBarIconBrightness: Brightness.dark, // Pour des icônes noires sur fond clair
  ));

  final userService = UserService();
  final authService = AuthService();
  final groupService = GroupService();
  final friendService = FriendService();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EntryPointController(authService)),
        ChangeNotifierProvider(create: (_) => ConversationListController(groupService)),
        ChangeNotifierProvider(create: (_) => FriendConversationController(friendService)),
        ChangeNotifierProvider(create: (_) => HomeController(userService)),
        ChangeNotifierProvider(create: (_) => LoginController(authService)),
        ChangeNotifierProvider(create: (_) => RegisterController(authService)),
        ChangeNotifierProvider(create: (_) => MeController(userService)),
        ChangeNotifierProvider(create: (_) => EditPersonalDataController(userService)),
      ],
      child: EntryPointView()
    ),
  );
}


