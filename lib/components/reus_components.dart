import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void navigateAndFinish(context, widget) => Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

Widget defaultFormField({
  required TextEditingController controller,
  FormFieldValidator<String>? validator,
  ValueChanged<String>? onChange,
  required TextInputType keyboardType,
  required bool obscureText,
  required Widget prefixIcon,
  required String? labelText,
  Widget? suffixIcon,
}) =>
    TextFormField(
      controller: controller,
      validator: validator,
      onChanged: onChange,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.redAccent,
        ),
        border: const OutlineInputBorder(),
      ),
    );

Widget defaultButton({
  required void Function()? onPressed,
  required String text,
}) =>
    Container(
      width: double.infinity,
      height: 40.0,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

void showToast({
  required String message,
  required ToastState state,
}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: colorToastState(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastState { success, warning, error }

Color colorToastState(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.success:
      color = Colors.green;
      break;
    case ToastState.error:
      color = Colors.red;
      break;
    case ToastState.warning:
      color = Colors.amberAccent;
      break;
  }
  return color;
}

Widget fadeReusImage({
  required String networkImage,
  String assetImage = 'assets/images/loading-icon-on-black-vector-24559837.jpg',
  double? height,
  double? width,
  BoxFit? fit,
}) =>
    FadeInImage(
      placeholder: AssetImage(
        assetImage,
      ),
      image: NetworkImage(
        networkImage,
      ),
      fit: fit,
      height: height,
      width: width,
    );

String? uid = '';
bool? isDark;
