import lang/constants.{ type LexerState, LexerState, Token, ArgumentClose }

pub fn process_argument_close(state: LexerState, remaining_chars: List(String)) -> #(Bool, LexerState, List(String)) {
   let argument_close_token = Token(
      tokentype: ArgumentClose,
      value: "#ARGUMENT_CLOSE#",
      position_x: state.position_x,
      position_y: state.position_y
   )

   #(True, LexerState(..state, tokens: [argument_close_token, ..state.tokens]), remaining_chars)
}
