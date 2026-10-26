import gleam/result
import gleam/option
import gleam/list
import lang/constants.{ type LexerState, type Token, Text }

const default_token = constants.Token(
   tokentype: Text,
   value: "",
   position_x: -1,
   position_y: -1
)

pub fn process_as_text(current_char: String, state: LexerState) -> LexerState {
   let latest_token_is_text: Bool = list.first(state.tokens)
      |> option.from_result
      |> option.map(fn(t) { t.tokentype == Text })
      |> option.unwrap(or: False)

   let latest_token: Token = list.first(state.tokens)
      |> result.unwrap(or: default_token) // Alt value not important - Never used

   case latest_token_is_text {
      True -> constants.LexerState(..state, tokens: [ // Add to the last token's value
         constants.Token(
            ..latest_token,
            value: latest_token.value <> current_char
         ), ..list.drop(state.tokens, 1)]
      )
      False -> constants.LexerState(..state, tokens: [ // Create new token
         constants.Token(
            tokentype: Text,
            value: current_char,
            position_x: state.position_x,
            position_y: state.position_y
         ), ..state.tokens]
      )
   }
}