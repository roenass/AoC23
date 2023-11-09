program cat(input, output);
var
	Line: string;
begin
  while not eof(input) do
  begin
    ReadLn(input,Line);
    writeLn(Line);
  end;
end.