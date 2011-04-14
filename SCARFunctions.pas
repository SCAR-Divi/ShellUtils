unit SCARFunctions;

interface

uses
  Windows, Graphics, SysUtils;

type
  TSCARPlugFunc = record
    Name: AnsiString;
    Ptr: Pointer;
  end;

  TDebugParams = record
    BackColor, Color: Cardinal;
    Name: AnsiString;
    Style: TFontStyles;
  end;

  TFunc_WriteLn = procedure(s: AnsiString); 
  TFunc_Status = procedure(s: AnsiString);
  TFunc_Wait = procedure(ms: Integer);
  TFunc_GetBitmapDc = function(Bmp: Integer): HDC;
  TFunc_GetSCARVersion = function: Integer;     
  TFunc_Disguise = procedure(Caption: string);
  TFunc_GetClientWindowHandle = function: Hwnd;
  TFunc_SetClientWindowHandle = procedure(H: Hwnd);
  TFunc_InCircle = function(x, y, mx, my, r: Integer): Boolean;
  TFunc_InTriangle = function(x, y, x1, y1, x2, y2, x3, y3: Integer): Boolean;
  TFunc_Distance = function(x1, y1, x2, y2: Integer): Integer;
  TFunc_ConvertTime = procedure(Ms: Integer; var H, M, S: Integer);
  TFunc_TerminateScript = procedure;
  TFunc_ClearDebug = procedure;
  TFunc_GetStatus = function: AnsiString;
  TFunc_AppPath = function: AnsiString;
  TFunc_ScriptPath = function: AnsiString;
  TFunc_AddToReport = procedure(s: AnsiString);
  TFunc_ClearReport = procedure;
  TFunc_MoveToTray = procedure;
  TFunc_ActivateClient = procedure;
  TFunc_GetDebugText = function: AnsiString;
  TFunc_DeleteDebugLine = procedure(Line: Integer);
  TFunc_GetDebugLineCount = function: Integer;
  TFunc_GetDebugLine = function(Line: Integer): AnsiString;
  TFunc_ClearDebugLine = procedure(Line: Integer);
  TFunc_ReplaceDebugLine = procedure(Line: Integer; s: AnsiString);
  TFunc_GetClientCanvas = function: TCanvas;
  TFunc_GetDebugCanvas = function: TCanvas;
  TFunc_GetTimeRunning = function: Integer;
  TFunc_SetTargetDC = procedure(Dc: HDC);
  TFunc_ResetDC = procedure;
  TFunc_SetDesktopAsClient = procedure;
  TFunc_GetTargetDC = function: HDC;
  TFunc_ResetCaption = procedure;
  TFunc_Alert = procedure(s: AnsiString);
  TFunc_GetClientDimensions = procedure(out Width, Height: Integer);
  TFunc_GetDebugParams = function: TDebugParams;
  TFunc_SetDebugParams = procedure(const Params: TDebugParams);
  TFunc_IncludesPath = function: AnsiString;
  TFunc_FontsPath = function: AnsiString;
  TFunc_LogsPath = function: AnsiString;
  TFunc_GetReportText = function: AnsiString;
  TFunc_ScreenPath = function: AnsiString;
  TFunc_GetClipboard = function: AnsiString;
  TFunc_SetClipboard = procedure(const Text: AnsiString);
  TFunc_ClearClipboard = procedure;

var
  WriteLn: TFunc_WriteLn;
  Status: TFunc_Status;
  Wait: TFunc_Wait;
  GetBitmapDc: TFunc_GetBitmapDc;
  GetSCARVersion: TFunc_GetSCARVersion;
  Disguise: TFunc_Disguise;
  GetClientWindowHandle: TFunc_GetClientWindowHandle;
  SetClientWindowHandle: TFunc_SetClientWindowHandle;
  InCircle: TFunc_InCircle;
  InTriangle: TFunc_InTriangle;
  Distance: TFunc_Distance;
  ConvertTime: TFunc_ConvertTime;
  TerminateScript: TFunc_TerminateScript;
  ClearDebug: TFunc_ClearDebug;
  GetStatus: TFunc_GetStatus;
  AppPath: TFunc_AppPath;
  AddToReport: TFunc_AddToReport;
  ScriptPath: TFunc_ScriptPath;
  ClearReport: TFunc_ClearReport;
  MoveToTray: TFunc_MoveToTray;
  ActivateClient: TFunc_ActivateClient;
  GetDebugText: TFunc_GetDebugText;
  DeleteDebugLine: TFunc_DeleteDebugLine;
  GetDebugLineCount: TFunc_GetDebugLineCount;
  GetDebugLine: TFunc_GetDebugLine;
  ClearDebugLine: TFunc_ClearDebugLine;
  ReplaceDebugLine: TFunc_ReplaceDebugLine;
  GetClientCanvas: TFunc_GetClientCanvas;
  GetDebugCanvas: TFunc_GetDebugCanvas;
  GetTimeRunning: TFunc_GetTimeRunning;
  SetTargetDC: TFunc_SetTargetDc;
  ResetDC: TFunc_ResetDc;
  SetDesktopAsClient: TFunc_SetDesktopAsClient;
  GetTargetDC: TFunc_GetTargetDC;
  ResetCaption: TFunc_ResetCaption;
  Alert: TFunc_Alert;
  GetClientDimensions: TFunc_GetClientDimensions;
  GetDebugParams: TFunc_GetDebugParams;
  SetDebugParams: TFunc_SetDebugParams;
  IncludesPath: TFunc_IncludesPath;
  FontsPath: TFunc_FontsPath;
  LogsPath: TFunc_LogsPath;
  GetReportText: TFunc_GetReportText;
  ScreenPath: TFunc_ScreenPath;
  GetClipboard: TFunc_GetClipboard;
  SetClipboard: TFunc_SetClipboard;
  ClearClipboard: TFunc_ClearClipboard;

implementation

procedure SetFunctions(Funcs: array of TSCARPlugFunc); stdcall;
var
  i: Integer;
  s: string;
begin
  for i := 0 to Length(Funcs) - 1 do
  begin
    s := UpperCase(Funcs[i].Name);
    if s = 'WRITELN' then
      WriteLn := Funcs[i].Ptr  
    else if s = 'STATUS' then
      Status := Funcs[i].Ptr
    else if s = 'WAIT' then
      Wait := Funcs[i].Ptr   
    else if s = 'GETBITMAPDC' then
      GetBitmapDc := Funcs[i].Ptr
    else if s = 'GETSCARVERSION' then
      GetSCARVersion := Funcs[i].Ptr
    else if s = 'DISGUISE' then
      Disguise := Funcs[i].Ptr  
    else if s = 'GETCLIENTWINDOWHANDLE' then
      GetClientWindowHandle := Funcs[i].Ptr
    else if s = 'SETCLIENTWINDOWHANDLE' then
      SetClientWindowHandle := Funcs[i].Ptr     
    else if s = 'INCIRCLE' then
      InCircle := Funcs[i].Ptr
    else if s = 'INTRIANGLE' then
      InTriangle := Funcs[i].Ptr
    else if s = 'DISTANCE' then
      Distance := Funcs[i].Ptr
    else if s = 'CONVERTTIME' then
      ConvertTime := Funcs[i].Ptr
    else if s = 'TERMINATESCRIPT' then
      TerminateScript := Funcs[i].Ptr
    else if s = 'CLEARDEBUG' then
      ClearDebug := Funcs[i].Ptr
    else if s = 'GETSTATUS' then
      GetStatus := Funcs[i].Ptr
    else if s = 'APPPATH' then
      AppPath := Funcs[i].Ptr
    else if s = 'SCRIPTPATH' then
      ScriptPath := Funcs[i].Ptr
    else if s = 'ADDTOREPORT' then
      AddToReport := Funcs[i].Ptr
    else if s = 'CLEARREPORT' then
      ClearReport := Funcs[i].Ptr
    else if s = 'MOVETOTRAY' then
      MoveToTray := Funcs[i].Ptr
    else if s = 'DISTANCE' then
      Distance := Funcs[i].Ptr
    else if s = 'ACTIVATECLIENT' then
      ActivateClient := Funcs[i].Ptr
    else if s = 'GETDEBUGTEXT' then
      GetDebugText := Funcs[i].Ptr
    else if s = 'DELETEDEBUGLINE' then
      DeleteDebugLine := Funcs[i].Ptr
    else if s = 'GETDEBUGLINECOUNT' then
      GetDebugLineCount := Funcs[i].Ptr
    else if s = 'GETDEBUGLINE' then
      GetDebugLine := Funcs[i].Ptr    
    else if s = 'CLEARDEBUGLINE' then
      ClearDebugLine := Funcs[i].Ptr
    else if s = 'REPLACEDEBUGLINE' then
      ReplaceDebugLine := Funcs[i].Ptr
    else if s = 'GETCLIENTCANVAS' then
      GetClientCanvas := Funcs[i].Ptr
    else if s = 'GETDEBUGCANVAS' then
      GetDebugCanvas := Funcs[i].Ptr
    else if s = 'GETTIMERUNNING' then
      GetTimeRunning := Funcs[i].Ptr
    else if s = 'SETTARGETDC' then
      SetTargetDC := Funcs[i].Ptr
    else if s = 'RESETDC' then
      ResetDC := Funcs[i].Ptr
    else if s = 'SETDESKTOPASCLIENT' then
      SetDesktopAsClient := Funcs[i].Ptr
    else if s = 'GETTARGETDC' then
      GetTargetDC := Funcs[i].Ptr
    else if s = 'RESETCAPTION' then
      ResetCaption := Funcs[i].Ptr
    else if s = 'ALERT' then
      Alert := Funcs[i].Ptr
    else if s = 'GETCLIENTDIMENSIONS' then
      GetClientDimensions := Funcs[i].Ptr
    else if s = 'GETDEBUGPARAMS' then
      GetDebugParams := Funcs[i].Ptr
    else if s = 'SETDEBUGPARAMS' then
      SetDebugParams := Funcs[i].Ptr
    else if s = 'INCLUDESPATH' then
      IncludesPath := Funcs[i].Ptr
    else if s = 'FONTSPATH' then
      FontsPath := Funcs[i].Ptr
    else if s = 'LOGSPATH' then
      LogsPath := Funcs[i].Ptr
    else if s = 'GETREPORTTEXT' then
      GetReportText := Funcs[i].Ptr
    else if s = 'SCREENPATH' then
      ScreenPath := Funcs[i].Ptr
    else if s = 'GETCLIPBOARD' then
      GetClipboard := Funcs[i].Ptr
    else if s = 'SETCLIPBOARD' then
      SetClipboard := Funcs[i].Ptr
    else if s = 'CLEARCLIPBOARD' then
      ClearClipboard := Funcs[i].Ptr;
  end;
end;

exports SetFunctions;

end.
 