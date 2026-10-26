import gleam/string
import gleam/int

import lang/lexer_processors/argument_close.{ process_argument_close }
import lang/lexer_processors/argument_open.{ process_argument_open }
import lang/lexer_processors/argument_separator.{ process_argument_separator }
import lang/lexer_processors/escape.{ process_escape }
import lang/lexer_processors/function.{ process_suspected_function }
import lang/lexer_processors/text.{ process_as_text }
import lang/constants.{ type LexerState, type Token }

// Note: Definitely dont run this function in multiple BEAM processes at once
// -- During Testing a single 3MB File ate ~100MB of Ram due to the use of List(String) with single chars --
pub fn create_flat_tokens(codebase: String) -> List(Token) {
   process_char_list_recursive(constants.LexerState(
      split_codebase: string.to_graphemes(codebase),
      tokens: [],
      position_x: 0,
      position_y: 0,
      is_escaped: False
   ))
}

fn process_char_list_recursive(state: LexerState) -> List(Token) {
   case state.split_codebase {
      [] -> state.tokens
      [current_char, ..rest] -> {
         // Calculate current position within the original codebase for error logging purposes
         let #(next_pos_x, next_pos_y) = case current_char {
            "\n" -> #(0, state.position_y + 1)
            _ -> #(state.position_x + 1, state.position_y)
         }

         let #(success, result_state, rest) = case state.is_escaped, current_char {
            False, "$" -> process_suspected_function(state, rest)
            False, "[" -> process_argument_open(state, rest)
            False, ";" -> process_argument_separator(state, rest)
            False, "]" -> process_argument_close(state, rest)
            False, "\\" -> process_escape(state, rest)
            False, _ -> #(False, state, rest)
            True, _ -> #(False, state, rest) // Escaped case
         }

         let result_state = case !success || result_state == state {
            False -> result_state // Should be impossible to hit accidentally, if not -> impossible to debug
            True -> constants.LexerState(..process_as_text(current_char, state), is_escaped: False)
         }

         process_char_list_recursive(constants.LexerState(
            ..result_state,
            split_codebase: rest,
            position_x: int.max(next_pos_x, result_state.position_x),
            position_y: int.max(next_pos_y, result_state.position_y)
         ))
      }
   }
}