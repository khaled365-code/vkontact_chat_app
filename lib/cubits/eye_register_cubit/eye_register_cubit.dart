import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'eye_register_state.dart';

class EyeRegisterCubit extends Cubit<EyeRegisterState> {
  EyeRegisterCubit() : super(EyeRegisterInitial());

  bool eyeDissapear=true;
  bool obsecureText=true;
  eyeRegisterChange()
  {
    emit(EyeRegisterDissapear());
    eyeDissapear=!eyeDissapear;
    obsecureText=!obsecureText;
    emit(EyeRegisterShow());


  }
}
