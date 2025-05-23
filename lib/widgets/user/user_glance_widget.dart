import 'package:flutter/cupertino.dart';

import '../../models/user.dart';

class UserGlanceWidget extends StatelessWidget {
  final User user;

  const UserGlanceWidget({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 10),
        Image.network(
          user.profilPictureRef,
          width: 200,
          height: 200,
        ),
        SizedBox(height: 15),
        Text(
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
          "${user.firstName} ${user.lastName}",
        ),
        SizedBox(height: 5),
        Text(
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
          ),
          user.email,
        ),
      ],
    );
  }
}