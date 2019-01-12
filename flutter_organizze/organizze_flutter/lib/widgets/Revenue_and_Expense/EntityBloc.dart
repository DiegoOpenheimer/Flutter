import 'package:organizze_flutter/components/Toast.dart';
import 'package:organizze_flutter/model/Movement.dart';

class EntityBloc {

  HelperToast _helperToast = HelperToast();

  void validateForm(Movement movement) {
    if (
      movement.value.toString().isEmpty ||
      movement.category.isEmpty ||
      movement.description.isEmpty
    ) {
      _helperToast.show('Preencha todos os campos corretamente', toastLong: true);
    } else  {
      saveMovement();
    }
  }

  void saveMovement() {
    print('ok');
  }

}