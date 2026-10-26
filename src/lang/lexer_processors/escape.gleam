import lang/constants.{ type LexerState, LexerState }

pub fn process_escape(state: LexerState, remaining_chars: List(String)) -> #(Bool, LexerState, List(String)) {
   #(True, LexerState(..state, is_escaped: True), remaining_chars)
}
