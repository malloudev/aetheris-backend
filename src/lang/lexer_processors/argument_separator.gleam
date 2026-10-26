import lang/constants.{ type LexerState, LexerState, Token, ArgumentSeparator }

pub fn process_argument_separator(state: LexerState, remaining_chars: List(String)) -> #(Bool, LexerState, List(String)) {
   let argument_separator_token = Token(
      tokentype: ArgumentSeparator,
      value: "#ARGUMENT_SEPARATOR#",
      position_x: state.position_x,
      position_y: state.position_y
   )

   #(True, LexerState(..state, tokens: [argument_separator_token, ..state.tokens]), remaining_chars)
}
