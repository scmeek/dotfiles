{ ... }:

let
  homeKey = builtins.fromJSON ''"\uf729"'';
  endKey = builtins.fromJSON ''"\uf72b"'';
in
{
  # Modifier prefixes: $ is shift, ^ is ctrl.
  targets.darwin.keybindings = {
    "${homeKey}" = "moveToBeginningOfParagraph:";
    "${endKey}" = "moveToEndOfParagraph:";
    "\$${homeKey}" = "moveToBeginningOfParagraphAndModifySelection:";
    "\$${endKey}" = "moveToEndOfParagraphAndModifySelection:";
    "^${homeKey}" = "moveToBeginningOfDocument:";
    "^${endKey}" = "moveToEndOfDocument:";
    "^\$${homeKey}" = "moveToBeginningOfDocumentAndModifySelection:";
    "^\$${endKey}" = "moveToEndOfDocumentAndModifySelection:";
  };
}
