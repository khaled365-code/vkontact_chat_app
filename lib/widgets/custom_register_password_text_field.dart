
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/eye_register_cubit/eye_register_cubit.dart';


class CustomRegisterPasswordField extends StatelessWidget {


   final passwordController;
   final eyeCubit;

  const CustomRegisterPasswordField({super.key, required this.passwordController,required this.eyeCubit});

  @override
  Widget build(BuildContext context)
  {
    return BlocBuilder<EyeRegisterCubit, EyeRegisterState>(
      builder: (context, state) {
        return TextFormField(
          controller: passwordController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
          style: TextStyle(color: Colors.black, fontSize: 18),
          obscureText: eyeCubit.obsecureText,
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
              hintText: 'Password',
              hintStyle: TextStyle(
                color: Colors.black.withOpacity(.5),
                fontSize: 18,
              ),
              fillColor: Colors.grey[100],
              filled: true,
              suffixIcon: InkWell(
                  onTap: () {
                    eyeCubit.eyeRegisterChange();
                  },
                  child: eyeCubit.eyeDissapear ? Icon(
                    Icons.visibility_off,
                    color: Colors.black,
                    size: 25,
                  ) : Icon(
                    Icons.remove_red_eye,
                    color: Colors.black,
                    size: 25,
                  )),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  )),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ))
          ),
        );
      },
    );
  }
}
