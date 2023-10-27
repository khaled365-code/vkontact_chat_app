import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'eye_login_state.dart';

class EyeLoginCubit extends Cubit<EyeLoginState> {
  EyeLoginCubit() : super(EyeLoginInitial());

  bool eyeDissapear=true;
  bool obsecureText=true;
  eyeLoginChange()
  {
    emit(EyeLoginDissapear());
    eyeDissapear=!eyeDissapear;
    obsecureText=!obsecureText;
    emit(EyeLoginShow());


  }
}
