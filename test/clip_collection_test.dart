import 'package:flutter/material.dart';
import 'package:flutter_my_clipboard/models/clipitem.model.dart';
import 'package:flutter_my_clipboard/services/datetime_service.dart';
import 'package:flutter_my_clipboard/ui/views/clip/clip_collection_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:screen_loader/screen_loader.dart';


void main() {
  group('ClipCollectionView', () {
    late ClipCollectionView clipCollectionView;
    late List<ClipItem> clips;

    setUp(() {
      clips = [
        ClipItem('Clip1',DateTimeService.currentDate,false,[],0,false),
        ClipItem('Clip2',DateTimeService.currentDate,false,[],0,false),
        ClipItem('Clip3',DateTimeService.currentDate,false,[],0,false),
      ];

      clipCollectionView = ClipCollectionView(
        title: 'Test Collection',
        clips: clips,
      );
    });

    testWidgets('renders title correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: clipCollectionView,
        ),
      );

      final titleFinder = find.text('Test Collection');
      expect(titleFinder, findsOneWidget);
    });

    testWidgets('updates clips count on color change', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: clipCollectionView,
        ),
      );

      final clipsCountFinder = find.text('3');
      expect(clipsCountFinder, findsOneWidget);

      clipCollectionView = ClipCollectionView(
        title: 'Test Collection',
        clips: clips,
        color: Colors.red,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: clipCollectionView,
        ),
      );

      final updatedClipsCountFinder = find.text('3');
      expect(updatedClipsCountFinder, findsOneWidget);
    });

    testWidgets('search clips', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: clipCollectionView,
        ),
      );

      final searchFieldFinder = find.byType(TextField);
      expect(searchFieldFinder, findsOneWidget);

      await tester.enterText(searchFieldFinder, 'Clip 2');
      await tester.pump();

      final clipItemFinder = find.text('Clip 2');
      expect(clipItemFinder, findsOneWidget);

      final otherClipItemFinder = find.text('Clip 1');
      expect(otherClipItemFinder, findsNothing);
    });
  });
}
