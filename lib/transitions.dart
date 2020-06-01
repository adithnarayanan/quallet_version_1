import 'package:flutter/material.dart';
import 'home.dart';
import 'slot.dart';

// custom screen transitions
Route slotScreenTransOne() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        SlotScreen(cardNumber: 1),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route slotScreenTransTwo() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        SlotScreen(cardNumber: 2),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

// Using navigator.pop()
// Route backHomeTrans() {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => Home(),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       // TODO: animate so current screen wipes off, not the home sreen wiping on
//       var begin = Offset(-1.0, 0.0);
//       var end = Offset.zero;
//       var curve = Curves.ease;

//       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

//       return SlideTransition(
//         position: animation.drive(tween),
//         child: child,
//       );
//     },
//   );
// }
