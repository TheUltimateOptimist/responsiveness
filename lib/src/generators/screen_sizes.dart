import 'dart:convert';

class ScreenSizes{
  ScreenSizes(this.names, this.minimumWidths);

  final List<String> names;
  final List<int> minimumWidths;

  factory ScreenSizes.fromJsonString(String json){
    final Map<String, int> screenSizes;
    try{
      screenSizes = Map<String, int>.from(jsonDecode(json));
    }
    catch(e){
      throw Exception("Parsing the screen_sizes.json content to a Map<String, int> failed. Please make sure, that the contents of screen_sizes.json can be parsed to a Map<String, int>.");
    }
    final screenSizeEntries = screenSizes.entries.toList();
    ScreenSizes.validateScreenSizeEntris(screenSizeEntries);
    screenSizeEntries.sort((a, b) => a.value.compareTo(b.value));
    final names = screenSizeEntries.map((entry) => entry.key).toList();
    final minimumWidths = screenSizeEntries.map((entry) => entry.value).toList();
    return ScreenSizes(names, minimumWidths);
  }

  static void validateScreenSizeEntris(List<MapEntry<String, int>> screenSizeEntries){
    if(screenSizeEntries.length < 2){
      throw Exception("You provided less than 2 different screen sizes in screen_sizes.json. Please provide at least 2 different screen sizes.");
    }
    if(screenSizeEntries.any((entry) => entry.value < 0)){
      throw Exception("You provided a negative minimum width for a screen size in screen_sizes.json. Please make sure that every screen size's minimum width is >= 0");
    }
    if(screenSizeEntries.any((entry) => RegExp("[^A-Z|a-z|_]").hasMatch(entry.key))){
      throw Exception("You provided an invalid screen size name in screen_sizes.json. Please make sure that every screen size name only uses the following symbols: A -Z, a - z, _");
    }
    if(!screenSizeEntries.any((entry) => entry.value == 0)){
      throw Exception("You didn't provide any screen size with a minimum with of 0 in screen_sizes.json. Please make sure that there is one screen size with a minimum with of 0 in screen_sizes.json.");
    }
    for(var screenSizeEntry in screenSizeEntries){
      final sameValueEntries = screenSizeEntries.where((entry) => entry.value == screenSizeEntry.value);
      if(sameValueEntries.length > 1){
        throw Exception("You provided two screen sizes with the same minimum width in screen_sizes.json. Please make sure that every screen size's minimum width is unique.");
      }
    }

  }
}