/// The class [Validators] contains the methods of type [String]
/// for all inputs that required validate by pattern or caracters
/// contents.
class Validators {
  /// the variable [noMatchEmail] of type [string] contains the response of the
  /// non-validated [email].
  final String? noMatchEmail;

  /// the variable [emptyEmail] of type [string] contains the response of the
  /// empty [email].
  final String? emptyEmail;

  /// the variable [noMatchNumberPhone] of type [string] contains the response of the
  /// non-validated [numberPhone].
  final String? noMatchNumberPhone;

  /// the variable [emptyNumberPhone] of type [string] contains the response of the
  /// empty [numberPhone].
  final String? emptyNumberPhone;

  /// the variable [emptyText] of type [string] contains the response of the
  /// empty [text].
  final String? emptyText;

  /// the variable [emptyDocument] of type [string] contains the response of the
  /// empty [text].
  final String? emptyDocument;

  /// the variable [noMatchDocument] of type [string] contains the response of the
  /// empty [text].
  final String? noMatchDocument;

  final String? emptyNumber;

  final String? noMatchNumber;

  Validators({
    this.noMatchEmail,
    this.emptyEmail,
    this.noMatchNumberPhone,
    this.emptyNumberPhone,
    this.emptyText,
    this.emptyDocument,
    this.noMatchDocument,
    this.emptyNumber,
    this.noMatchNumber,
  });

  /// The variable private [_emailRegExp] the type [RegExp] contains
  /// the pattern to validate the emails.
  static final RegExp _emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  /// The variable private [_phoneRegExp] the type [RegExp] contains
  /// the pattern to validate the number phone.
  static final RegExp _phoneRegExp = RegExp(r'(^(?:[+0]9)?[0-9]{6,12}$)');

  static final RegExp _regExpNameLastName = RegExp(r'(^[a-zA-Z\s]*$)');

  static final RegExp _usaPhoneCode = RegExp(r'(^[0-9]{3,3}$)');

  /// The method [validateEmail] receives as a parameter the variable
  /// [email] of type [string], the variable [email] is valued with the
  /// [_emailRegExp] pattern and, according to the conditions, returns the
  /// following values:
  ///
  /// -> If the variable [email] doesn't match the [_emailRegExp] pattern, this method
  /// will return the value of the variable [noMatchEmail].
  ///
  /// -> If the variable [email] doesn't have characters, this method
  /// will return the value of the variable [emptyEmail].
  ///
  /// -> If the variable [email] does have characters and match the [_emailRegExp] pattern,
  ///  this method will return [null].
  String? validateEmail({required String email, required context}) {
    // ignore: prefer_is_empty
    if (email.length == 0 || email.isEmpty) {
      return "The min. character is 6";
    } else if (!_emailRegExp.hasMatch(email)) {
      return "Email is required";
    }
    return null;
  }

  String? validateCode({required String code}) {
    // ignore: prefer_is_empty
    if (code.length == 0 || code.isEmpty) {
      return 'This field is required';
    } else if (!_usaPhoneCode.hasMatch(code)) {
      return 'Invalid code';
    }
    return null;
  }

  /// The method [validatePhone] receives as a parameter the variable
  /// [numberPhone] of type [string], the variable [numberPhone] is valued with the
  /// [_phoneRegExp] pattern and, according to the conditions, returns the
  /// following values:
  ///
  /// -> If the variable [numberPhone] doesn't match the [_phoneRegExp] pattern, this method
  /// will return the value of the variable [noMatchNumberPhone].
  ///
  /// -> If the variable [numberPhone] doesn't have characters, this method
  /// will return the value of the variable [emptyNumberPhone].
  ///
  /// -> If the variable [numberPhone] does have characters and match the [_phoneRegExp],
  ///  this method will return [null].
  String? validatePhone({required String numberPhone}) {
    // ignore: prefer_is_empty
    if (numberPhone.length == 0 || numberPhone.isEmpty) {
      return 'This field is required';
    } else if (!_phoneRegExp.hasMatch(numberPhone)) {
      return 'The phone number is not valid';
    }
    return null;
  }

  /// The method [validatePassword] receives as a parameter the variable
  /// [password] of type [string], the variable [password] is valued with the
  /// conditions, returns the following values:
  String? validatePassword({required String password}) {
    // ignore: prefer_is_empty
    if (password.isEmpty || password.length == 0) {
      return 'This field is required';
    } else if (password.length < 6) {
      return 'The password must have at least 6 characters';
    } else if (password.length > 20) {
      return 'The password must have less than 20 characters';
    }
    return null;
  }

  /// The method [validateText] receives as a parameter the variable
  /// [text] of type [string], the variable [text] is valued with the
  ///  the conditions, returns the following values:
  ///
  /// -> If the variable [numberPhone] doesn't have characters, this method
  /// will return the value of the variable [emptyNumberPhone].
  ///
  /// -> If the variable [numberPhone] does have characters,
  ///  this method will return [null].
  String? validateText({required String text}) {
    // ignore: prefer_is_empty
    if (text.isEmpty || text.length < 0) {
      return 'This field is required';
    }
    return null;
  }

  String? noValidate({required String text}) {
    return null;
  }

  String? validateName({required String text}) {
    // ignore: prefer_is_empty
    if (text.isEmpty || text.length < 0) {
      return 'This field is required';
    } else if (!_regExpNameLastName.hasMatch(text)) {
      return 'The name is not valid';
    }
    return null;
  }

  String? validateMemberId({required String text}) {
    // ignore: prefer_is_empty
    if (text.isEmpty || text.length != 8) {
      return 'La matricula debe ser de 8 dígitos';
    }
    return null;
  }

  String? validateSegmentName({required String text}) {
    // ignore: prefer_is_empty
    if (text.isEmpty || text.length < 0) {
      return 'This field is required';
    }
    return null;
  }

  String? validateLastName({required String text}) {
    // ignore: prefer_is_empty
    if (text.isEmpty || text.length < 0) {
      return 'This field is required';
    } else if (!_regExpNameLastName.hasMatch(text)) {
      return 'The last name is not valid';
    }
    return null;
  }

  String? confirmPassword({required String pass, required String confirmPass}) {
    if (pass != confirmPass) {
      return 'The password does not match';
    }
    return null;
  }
}

/// Exports [validators]
Validators validators = Validators();
