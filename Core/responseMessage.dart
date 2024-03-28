import 'package:zutomayoddeck/Constant/constant.dart';

class ResultProperty {
  String Status;

  String Meesage;

  ResultProperty(
      {this.Status = ResultPropertyConstants.StatusError,
      this.Meesage = "Default Message"});
}
