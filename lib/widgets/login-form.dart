// IMPORTANT
// After deciding to go only with google auth, this widget became redundant

// import 'package:WordFishing/theme/palette.dart';
// import 'package:WordFishing/utils/spacing.dart';
// import 'package:flutter/material.dart';

// class LoginForm extends StatefulWidget {
//   final Function onSubmit;

//   LoginForm({this.onSubmit});

//   @override
//   _LoginFormState createState() => _LoginFormState();
// }

// class _LoginFormState extends State<LoginForm> {
//   final _loginFocusNode = FocusNode();
//   final _passwordFocusNode = FocusNode();
//   final _repeatPasswordFocusNode = FocusNode();

//   Map<String, String> _authData = {
//     'email': '',
//     'password': '',
//     'password_repeat': '',
//   };

//   bool _isSignUp = false;

//   final _form = GlobalKey<FormState>();

//   void onBackgroundTap() {
//     print("Hello");
//     _loginFocusNode.unfocus();
//     _passwordFocusNode.unfocus();
//   }

//   void onSwitchButtonPress() {
//     setState(() {
//       _isSignUp = !_isSignUp;
//     });
//   }

//   Future<void> _submitForm() async {
//     _form.currentState.save();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final inputTextStyle = TextStyle(
//       color: Theme.of(context).textTheme.subtitle1.color,
//     );
//     final labelStyle = TextStyle(
//       color: inputTextStyle.color,
//     );
//     final enabledBorder = UnderlineInputBorder(
//       borderSide: BorderSide(
//         color: inputTextStyle.color,
//       ),
//     );
//     final focusedBorder = UnderlineInputBorder(
//       borderSide: BorderSide(
//         color: Theme.of(context).accentColor,
//       ),
//     );

//     return LayoutBuilder(
//       builder: (context, constraints) => Center(
//         child: GestureDetector(
//           onTap: onBackgroundTap,
//           child: Container(
//             width: constraints.maxWidth,
//             height: constraints.maxHeight,
//             decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
//             child: Center(
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: spacing[5]),
//                 child: Form(
//                   key: _form,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         _isSignUp ? 'Sign up' : "Login",
//                         style: Theme.of(context).textTheme.headline4.copyWith(
//                               fontWeight: FontWeight.bold,
//                             ),
//                         textAlign: TextAlign.left,
//                       ),
//                       SizedBox(
//                         height: spacing[5],
//                       ),
//                       TextFormField(
//                         initialValue: '',
//                         decoration: InputDecoration(
//                           labelText: 'Email',
//                           labelStyle: labelStyle,
//                           enabledBorder: enabledBorder,
//                           focusedBorder: focusedBorder,
//                         ),
//                         textInputAction: TextInputAction.next,
//                         keyboardType: TextInputType.emailAddress,
//                         focusNode: _loginFocusNode,
//                         style: inputTextStyle,
//                         onFieldSubmitted: (_) {
//                           FocusScope.of(context)
//                               .requestFocus(_passwordFocusNode);
//                         },
//                         validator: (value) {
//                           if (value.isEmpty) {
//                             return 'Please enter a price.';
//                           }
//                           if (double.tryParse(value) == null) {
//                             return 'Please enter a valid number.';
//                           }
//                           if (double.parse(value) <= 0) {
//                             return 'Please enter a number greater than zero.';
//                           }
//                           return null;
//                         },
//                         onSaved: (value) {
//                           _authData['email'] = value;
//                         },
//                       ),
//                       SizedBox(
//                         height: spacing[3],
//                       ),
//                       TextFormField(
//                         initialValue: '',
//                         decoration: InputDecoration(
//                           labelText: 'Password',
//                           labelStyle: labelStyle,
//                           enabledBorder: enabledBorder,
//                           focusedBorder: focusedBorder,
//                         ),
//                         textInputAction: _isSignUp
//                             ? TextInputAction.next
//                             : TextInputAction.done,
//                         style: inputTextStyle,
//                         // keyboardType: TextInputType.visiblePassword,
//                         obscureText: true,
//                         autocorrect: false,
//                         enableSuggestions: false,
//                         focusNode: _passwordFocusNode,
//                         onFieldSubmitted: (_) {
//                           FocusScope.of(context)
//                               .requestFocus(_repeatPasswordFocusNode);
//                         },
//                         validator: (value) {
//                           if (value.isEmpty) {
//                             return 'Please enter a price.';
//                           }
//                           if (double.tryParse(value) == null) {
//                             return 'Please enter a valid number.';
//                           }
//                           if (double.parse(value) <= 0) {
//                             return 'Please enter a number greater than zero.';
//                           }
//                           return null;
//                         },
//                         onSaved: (value) {
//                           _authData['password'] = value;
//                         },
//                       ),
//                       if (_isSignUp)
//                         TextFormField(
//                           initialValue: '',
//                           decoration: InputDecoration(
//                             labelText: 'Repeat password',
//                             labelStyle: labelStyle,
//                             enabledBorder: enabledBorder,
//                             focusedBorder: focusedBorder,
//                           ),
//                           textInputAction: TextInputAction.done,
//                           style: inputTextStyle,
//                           // keyboardType: TextInputType.visiblePassword,
//                           obscureText: true,
//                           autocorrect: false,
//                           enableSuggestions: false,
//                           focusNode: _repeatPasswordFocusNode,
//                           onFieldSubmitted: (_) {
//                             // FocusScope.of(context).requestFocus(_descriptionFocusNode);
//                           },
//                           validator: (value) {
//                             if (value.isEmpty) {
//                               return 'Please enter a price.';
//                             }
//                             if (double.tryParse(value) == null) {
//                               return 'Please enter a valid number.';
//                             }
//                             if (double.parse(value) <= 0) {
//                               return 'Please enter a number greater than zero.';
//                             }
//                             return null;
//                           },
//                           onSaved: (value) {
//                             _authData['password_repeat'] = value;
//                           },
//                         ),
//                       SizedBox(
//                         height: spacing[5],
//                       ),
//                       Container(
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           color: Theme.of(context).accentColor,
//                         ),
//                         child: FlatButton(
//                           onPressed: _submitForm,
//                           child: Text(
//                             _isSignUp ? "Sign up" : "Login",
//                             style: Theme.of(context).textTheme.headline6,
//                           ),
//                         ),
//                       ),
//                       Container(
//                         width: double.infinity,
//                         child: FlatButton(
//                           onPressed: onSwitchButtonPress,
//                           child: Text(
//                             _isSignUp ? "Login instead" : "Sign up instead",
//                             style: Theme.of(context).textTheme.bodyText2,
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
