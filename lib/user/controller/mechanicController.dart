import 'package:get/get.dart';

class MechanicController extends GetxController {

//final MyRepository repository;
//MechanicController({@required this.repository}) : assert(repository != null);

  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;
}