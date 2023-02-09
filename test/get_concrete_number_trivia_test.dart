import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:numbers_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:numbers_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:numbers_trivia/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  GetConcreteNumberTrivia usecase;
  MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository);
  });

  final tNumber = 1;
  final tNumberTrivia = NumberTrivia(number: 1, text: 'test');

  test('should get trivia for the number from the repository', () async {
    when(mockNumberTriviaRepository.getConcretenumberTrivia(any))
        .thenAnswer((_) async => Right(tNumberTrivia));
    final result = await usecase.execute(number: tNumber);
    //usecase should simply return whatever was returned from the repository.
    expect(result, Right(tNumberTrivia));
    //verify that the method should be called and nothing more.
    verify(mockNumberTriviaRepository.getConcretenumberTrivia(tNumber));
    //only the above methos should be called and nothing more.
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}
