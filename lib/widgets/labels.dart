// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String ruta;

  const Labels({
    super.key,
    required this.ruta,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              ruta != 'login'
                  ? Navigator.pushReplacementNamed(context, 'register')
                  : Navigator.pushReplacementNamed(context, 'login');
            },
            child: ruta != 'login'
                ? const Text(
                    'Register here a',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 15,
                        fontWeight: FontWeight.w300),
                  )
                : const Text(
                    'Login with',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 15,
                        fontWeight: FontWeight.w300),
                  ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              ruta != 'login'
                  ? Navigator.pushReplacementNamed(context, 'register')
                  : Navigator.pushReplacementNamed(context, 'login');
            },
            child: ruta != 'login'
                ? Text(
                    'New Account',
                    style: TextStyle(
                        color: Colors.blue[600],
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )
                : Text(
                    'Your Account',
                    style: TextStyle(
                        color: Colors.blue[600],
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
          ),
        ],
      ),
    );
  }
}
