import lang/constants.{ type AbstractToken, type Token, type ParserState, Function }

const placeholder_function_token = constants.AbstractToken(
    tokentype: Function,
    position_x: -1,
    position_y: -1
)

pub fn parse_into_ast(tokens: List(Token)) -> List(AbstractToken) {
   process_token_recursive(constants.ParserState(
      argument_frame_stack: [],
      body_frame_stack: [],
      final_tokens: [],
      original_tokens: tokens,
      current_function_token: placeholder_function_token
   ))
}

fn process_token_recursive(state: ParserState) -> List(AbstractToken) {
    case state.original_tokens {
        [] -> state.final_tokens
        [current_token, ..rest] -> {


          process_token_recursive(constants.ParserState(
            ..state
          ))
        }
    }
}