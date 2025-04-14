import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_picsou/controllers/conversation_list_controller.dart';
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

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EntryPointController(AuthService())),
        ChangeNotifierProvider(create: (_) => ConversationListController(GroupService())),
        ChangeNotifierProvider(create: (_) => FriendConversationController(FriendService())),
        ChangeNotifierProvider(create: (_) => HomeController(UserService())),
        ChangeNotifierProvider(create: (_) => LoginController(AuthService())),
        ChangeNotifierProvider(create: (_) => RegisterController(AuthService())),
        ChangeNotifierProvider(create: (_) => MeController()),
      ],
      child: EntryPointView()
    ),
  );
}


