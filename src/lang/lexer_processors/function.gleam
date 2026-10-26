import gleam/list
import lang/constants.{ type LexerState }

const function_name_limiter = 30

pub fn process_suspected_function(state: LexerState, remaining_chars: List(String)) -> #(Bool, LexerState, List(String)) {
  let search_radius = list.take(remaining_chars, function_name_limiter)



    #(True, state, remaining_chars)
}