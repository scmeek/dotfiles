{ ... }:

let
  homeKey = builtins.fromJSON ''"\uf729"'';
  endKey = builtins.fromJSON ''"\uf72b"'';
in
{
  targets.darwin.keybindings = {
    "${homeKey}" = "moveToBeginningOfParagraph:";
    "${endKey}" = "moveToEndOfParagraph:";
    "${"$" + homeKey}" = "moveToBeginningOfParagraphAndModifySelection:"; # shift-home
    "${"$" + endKey}" = "moveToEndOfParagraphAndModifySelection:";
    "^${homeKey}" = "moveToBeginningOfDocument:";
    "^${endKey}" = "moveToEndOfDocument:";
    "${"^$" + homeKey}" = "moveToBeginningOfDocumentAndModifySelection:"; # ctrl-shift-home
    "${"^$" + endKey}" = "moveToEndOfDocumentAndModifySelection:"; # ctrl-shift-end
  };
}
