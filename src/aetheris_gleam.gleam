import lang/lexer
import gleam/list

pub fn main() -> Nil {
   let result = lexer.create_flat_tokens("hello world];hello world[")

   echo list.reverse(result)
   Nil
}
