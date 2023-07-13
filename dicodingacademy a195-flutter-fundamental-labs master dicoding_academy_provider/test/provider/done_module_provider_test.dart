// import 'package:dicodingacademy/provider/done_module_provider.dart';
// import 'package:flutter_test/flutter_test.dart';

// // void main() {
// //   test('should contain new item when module completed', () {
// //     // arrange
// //     var doneModuleProvider = DoneModuleProvider();
// //     var testModuleName = 'Test Module';

// //     // act
// //     doneModuleProvider.complete(testModuleName);

// //     // assert
// //     var result = doneModuleProvider.doneModuleList.contains(testModuleName);
// //     expect(result, false);
// //   });
// // }

// void main() {
//   group('Provider Test', () {
//     final testModuleName = 'Test Module';
//     DoneModuleProvider doneModuleProvider;

//     setUp(() {
//       doneModuleProvider = DoneModuleProvider();
//     });

//     test('should contain new item when module completed', () {
//       // act
//       doneModuleProvider.complete(testModuleName);
//       // assert
//       var result = doneModuleProvider.doneModuleList.contains(testModuleName);
//       expect(result, true);
//     });

//     test('should not contain item when module removed', () {
//       // act
//       doneModuleProvider.remove(testModuleName);
//       // assert
//       var result = doneModuleProvider.doneModuleList.contains(testModuleName);
//       expect(result, false);
//     });
//   });
// }
