pub type Tokentype {
   Function
   Text
   ArgumentOpen
   ArgumentClose
   ArgumentSeparator
}

pub type Token {
   Token(
      tokentype: Tokentype,
      value: String,
      position_x: Int,
      position_y: Int,
   )
}

pub type AbstractToken {
  AbstractToken(
    tokentype: Tokentype,
    position_x: Int,
    position_y: Int
  )
}

pub type BodyFrameStackEntry {
  BodyFrameStackEntry(
    tokens: List(AbstractToken),
    start_depth: Int
  )
}

pub type ParserState {
  ParserState(
    final_tokens: List(AbstractToken),
    original_tokens: List(Token),
    argument_frame_stack: List(List(List(Token))),
    body_frame_stack: List(BodyFrameStackEntry),
    current_function_token: AbstractToken
  )
}

pub type LexerState {
   LexerState(
      split_codebase: List(String),
      tokens: List(Token),
      position_x: Int,
      position_y: Int,
      is_escaped: Bool
   )
}
