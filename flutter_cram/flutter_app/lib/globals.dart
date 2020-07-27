import 'package:flutter/cupertino.dart';

ValueNotifier<int> listVersion = ValueNotifier<int>(0);

class Globals{

  void addList(){
    listVersion.value += 1;
    print(listVersion);
  }

}

