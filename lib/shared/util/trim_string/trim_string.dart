import 'package:ksu_budidaya/core.dart';

trimString(String? string) {
  if (string == null) {
    return "";
  } else if (string == "         ") {
    return "";
  } else if (string.contains("null")) {
    return "";
  } else {
    final trimmedString = string.trim();
    return trimmedString.isEmpty ? "" : trimmedString;
  }
}

convertTitle(String text) {
  if (text.isEmpty) {
    return text;
  }
  try {
    String data = text.split('_').map((word) {
      if (word.isEmpty) {
        return word;
      }
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
    return data.toUpperCase();
  } catch (e) {
    return "";
  }
}

trimStringStrip(String? string) {
  if (string == null) {
    return "-";
  } else if (string.contains("null")) {
    return "-";
  } else {
    final trimmedString = string.trim();
    return trimmedString.isEmpty ? "-" : trimmedString;
  }
}

checkDate(String? date) {
  if (date == null) {
    return "";
  } else if (date.trim().contains("null")) {
    return "";
  } else {
    final trimmedString = date.trim();
    return trimmedString.isEmpty
        ? formatSelectedDate(DateTime.now())
        : trimmedString;
  }
}

checkNull(String? string) {
  if (string == null) {
    return "";
  } else if (string.contains("null")) {
    return "";
  } else {
    return string;
  }
}

checkModel(dynamic data) {
  if (data == null) {
    return null;
  } else if (data.runtimeType == String) {
    return data;
  } else if (data.runtimeType == bool) {
    return data;
  } else if (data.runtimeType == double) {
    return data;
  } else {
    return data.toString();
  }
}

int hitungDpp(String? nilaiJual, String Bobot) {
  dynamic result =
      (((int.tryParse(nilaiJual ?? "0") ?? 0) * (double.tryParse(Bobot) ?? 0)) /
                  1000)
              .round() *
          1000;
  return result;
}

List<String> parseFileExtensions(String extensions) {
  if (extensions.isNotEmpty) {
    return extensions
        .split(';')
        .map((ext) => ext.replaceAll('.', ''))
        .where((ext) => ext.isNotEmpty)
        .toList();
  }
  return [];
}

String mimeTypeToExtension(String mimeType) {
  if (mimeType.contains(".")) {
    List<String> parts = mimeType.split('.');
    if (parts.length > 1) {
      return '.${parts.last}';
    } else {
      return mimeType;
    }
  } else {
    List<String> parts = mimeType.split('/');
    if (parts.length > 1) {
      return '.${parts.last}';
    } else {
      return mimeType;
    }
  }
}

bool checkRole(String role, String reqRole) {
  bool isEnable = false;
  if (reqRole.contains(";")) {
    List<String> parts =
        reqRole.split(';').where((s) => (s).isNotEmpty).toList();
    if (parts.isNotEmpty) {
      for (var i = 0; i < parts.length; i++) {
        if (trimString(parts[i]) == trimString(role)) {
          isEnable = true;
        }
      }
    }
  } else {
    if (trimString(role) == trimString(reqRole)) {
      isEnable = true;
    }
  }
  return isEnable;
}

List<T?> createNullList<T>(int length) {
  return List<T?>.filled(length, null, growable: false);
}

String toCamelCase(String input) {
  try {
    List<String> parts = input.split('_');
    String camelCase = parts.first +
        parts.skip(1).map((String part) {
          return part.isNotEmpty
              ? part[0].toUpperCase() + part.substring(1)
              : '';
        }).join('');
    return camelCase;
  } catch (e) {
    return input;
  }
}
