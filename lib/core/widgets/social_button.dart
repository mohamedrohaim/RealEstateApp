import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: Text(
            '- or sign in with -',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  print('google');
                },
                child: Container(
                  height: 55,
                  padding: const EdgeInsets.all(10.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.1), blurRadius: 10)
                      ]),
                  child: Image.asset(
                    'assets/Google.png',
                    height: 30,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  print('faceBook');
                },
                child: Container(
                  height: 55,
                  padding: const EdgeInsets.all(10.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.1), blurRadius: 10)
                      ]),
                  child: Image.asset(
                    'assets/Facebook.png',
                    height: 35,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  print('apple');
                },
                child: Container(
                  height: 55,
                  padding: const EdgeInsets.all(10.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.1), blurRadius: 10)
                      ]),
                  child: Image.asset(
                    'assets/apple .png',
                    height: 30,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}