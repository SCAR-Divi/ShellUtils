unit ShellUtils_Globals;

interface

uses
  SCARFunctions, ShellUtils_Main, SysUtils, Dialogs;

type
  TExportFunc = record
    Ptr: Pointer;
    Name: AnsiString;
  end;

const
  ExportFunctions: array[0..2] of TExportFunc =
    ((Ptr: @MyRun; Name: 'procedure Run(const Path: AnsiString);'),
     (Ptr: @MyRunEx; Name: 'procedure RunEx(const Path, Params: AnsiString);'),
     (Ptr: @MyDeleteFile; Name: 'function DeleteFile(const Path: AnsiString): Boolean;'));

function GetFunctionCount: Integer; stdcall;
function GetFunctionInfo(x: Integer; var ProcAddr: Pointer; var ProcDef: PAnsiChar): Integer; stdcall;

implementation

function GetFunctionCount: Integer; stdcall;
begin
  Result := High(ExportFunctions) + 1;
end;

function GetFunctionInfo(x: Integer; var ProcAddr: Pointer; var ProcDef: PAnsiChar): Integer; stdcall;
begin
  WriteLn(IntToStr(GetSCARVersion));
  Result := -1;
  if (x >= Low(ExportFunctions)) and (x <= High(ExportFunctions)) then
  begin
    ProcAddr := ExportFunctions[x].Ptr;
    StrPCopy(ProcDef, ExportFunctions[x].Name);
    Result := x;
  end;
end;

end.
