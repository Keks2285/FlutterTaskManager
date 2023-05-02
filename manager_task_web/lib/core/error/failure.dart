abstract class Failure{
  String errorMessage = '';
  int code = 0;
}

@override
class DefaultFailure implements Failure{
  int code = 0;

  String errorMessage = 'Неизвестная ошибка';  
}