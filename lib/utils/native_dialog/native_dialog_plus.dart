// class DialogAction {
//   final String text;
//   final VoidCallback onPressed;
//   final bool isDefault;
//   final bool isDestructive;
//
//   const DialogAction({
//     required this.text,
//     required this.onPressed,
//     this.isDefault = false,
//     this.isDestructive = false,
//   });
// }
//
// void showNativeDialog({
//   required BuildContext context,
//   required String title,
//   required String content,
//   required List<DialogAction> actions,
// }) {
//   if (Platform.isIOS) {
//     showCupertinoDialog(
//       context: context,
//       builder: (BuildContext context) => CupertinoAlertDialog(
//         title: Text(title),
//         content: Text(content),
//         actions: actions
//             .map((action) => CupertinoDialogAction(
//                   onPressed: action.onPressed,
//                   isDefaultAction: action.isDefault,
//                   isDestructiveAction: action.isDestructive,
//                   child: Text(action.text),
//                 ))
//             .toList(),
//       ),
//     );
//   } else {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         title: Text(title),
//         content: Text(content),
//         actions: actions
//             .map((action) => TextButton(
//                   onPressed: action.onPressed,
//                   style: action.isDestructive
//                       ? TextButton.styleFrom(foregroundColor: Colors.red)
//                       : null,
//                   child: Text(action.text),
//                 ))
//             .toList(),
//       ),
//     );
//   }
// }
