class IncrementAction {

  int value;

  IncrementAction(this.value);

}

class DecrementAction {

  int value;

  DecrementAction(this.value);

}


int counterIncrementReducer(int value, IncrementAction incrementAction) =>
    value + incrementAction.value;

int counterDecrementReducer(int value, DecrementAction decrementAction) =>
    value - decrementAction.value;