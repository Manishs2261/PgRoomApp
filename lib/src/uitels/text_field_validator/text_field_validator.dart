class EmailValidator {
  static String? validate(String? value) {
    return value==null ||  value.isEmpty ? "Email can't be empty" : null;
  }
}

class PasswordValidator {
  static String? validate(String? value) {
    return value==null ||value.isEmpty ? "Password can't be empty" : null;
  }
}

class AddressValidator {
  static String? validate(String? value) {
    return value==null ||value.isEmpty ? "Address can't be empty" : null;
  }
}

class CityValidator {
  static String? validate(String? value) {
    return value==null ||value.isEmpty ? "City can't be empty" : null;
  }
}

class LandMarkValidator {
  static String? validate(String? value) {
    return value==null ||value.isEmpty ? "Land Mark address can't be empty" :
    null;
  }
}

class ContactNumberValidator {
  static String? validate(String? value) {
    return value==null ||value.isEmpty ? "Password can't be empty" : null;
  }
}