import 'dart:io';

String readFixture(String name) =>
    File("test/core/fixture/$name").readAsStringSync();
