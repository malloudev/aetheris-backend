import lang/constants.{ type LexerState, LexerState, Token, ArgumentOpen, Function }
import gleam/option
import gleam/list

pub fn process_argument_open(state: LexerState, remaining_chars: List(String)) -> #(Bool, LexerState, List(String)) {
   let is_lastest_a_function: Bool = list.first(state.tokens)
      |> option.from_result
      |> option.map(fn(t) { t.tokentype == Function })
      |> option.unwrap(or: False)

   case is_lastest_a_function {
      False -> #(False, state, remaining_chars)
      True -> {
         let argument_open_token = Token(
            tokentype: ArgumentOpen,
            value: "#ARGUMENT_OPEN#",
            position_x: state.position_x,
            position_y: state.position_y
         )

         #(True, LexerState(..state, tokens: [argument_open_token, ..state.tokens]), remaining_chars)
      }
   }
}