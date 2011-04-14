unit ShellUtils_Main;

interface

uses
  SCARFunctions, ShellApi, Windows, SysUtils;

procedure MyRun(const Path: AnsiString); stdcall;
procedure MyRunEx(const Path, Params: AnsiString); stdcall;
function MyDeleteFile(const Path: AnsiString): Boolean;

implementation

procedure MyRun(const Path: AnsiString); stdcall;
begin
  ShellExecuteA(0, 'open', PAnsiChar(Path), nil, nil, SW_SHOWNORMAL);
end;

procedure MyRunEx(const Path, Params: AnsiString); stdcall;
begin
  ShellExecuteA(0, 'open', PAnsiChar(Path), PAnsiChar(Params), nil, SW_SHOWNORMAL);
end;

function MyDeleteFile(const Path: AnsiString): Boolean;
begin
  Result := False;
  if FileExists(Path) then
    if DeleteFile(Path) then
      Result := True;
end;

end.
