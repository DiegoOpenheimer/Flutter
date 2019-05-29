import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:try_bloc_pattern/services/GraphQLClient.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Message {

  String id;
  String author;
  String content;
  Description description;

  Message.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    author = map['author'];
    content = map['content'];
    description = Description.fromMap(map['description']);
  }

}

class Description {

  String when;
  String message;

  Description.fromMap(Map<String, dynamic> map) {
    when = map['when'];
    message = map['message'];
  }

}

class ModelMessageWidget {

  bool isLoading = false;
  List<Message> list = List();

}


class BlocMessage extends BlocBase {

  GraphQLClient graphQLClient;

  BlocMessage(this.graphQLClient) {
    assert(graphQLClient != null);
  }

  BehaviorSubject<ModelMessageWidget> _subject = BehaviorSubject.seeded(ModelMessageWidget());

  Observable<ModelMessageWidget> get outMessages => _subject.stream;

  BehaviorSubject<bool> _subjectLoading = BehaviorSubject.seeded(false);
  Observable<bool> get outLoadingRequest => _subjectLoading.stream;

  void insertMessages({ String author = 'Diego', String content = 'Studing', String description = 'GraphQL' }) async {
    _subjectLoading.add( true );
    try {
      await graphQLClient.mutate(query: _queryMutate(author, content, description));
      _subjectLoading.add( false );
      getMessages(showLoading: false);
    } catch(e) {
      _subjectLoading.add( false );
      showToast(msg: 'Falha na requisição');
    }
  }

  void getMessages({ bool showLoading = true }) async {
    if (showLoading) {
      _subject.add(_subject.value..isLoading = true);
    }

    try {
      List<Message> list = await graphQLClient.query(query: _query());
      _subject.add(
        _subject.value
          ..isLoading = false
          ..list = list
      );
    } catch(e) {
      _subject.add(_subject.value..isLoading = false);
      showToast(msg: 'Falha na requisição');
    }
  }

  String _queryMutate(String author, String content, String description) {
    return '''
      mutation {
        createMessage(input: {
          author: "$author",
          content: "$content",
          description: "$description",
        }) {
          id
          author
        }
      }    
    ''';
  }

  String _query() {
    return '''
      query {
        getAll {
          id
          author
          content
          description {
            message
          }
        }
      }    
    ''';
  }

  @override
  void dispose() {
    super.dispose();
    _subject.close();
    _subjectLoading.close();
  }

  void showToast({ String msg }) {
    Fluttertoast.showToast(
      toastLength: Toast.LENGTH_LONG,
      msg: msg
    );
  }

}