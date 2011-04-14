unit FastShareMem;

// By Frederic Hannes (http://ibeblog.com)
// Based on FastShareMem by Emil M. Santos (http://www.codexterity.com)

interface

var
  GetAllocMemCount: function: Integer;
  GetAllocMemSize: function: Integer;

implementation

uses Windows;

const
  ClassName = '_com.codexterity.fastsharemem.dataclass';

type
  TFastShareMem = record
    MemoryManager: TMemoryManagerEx;
    _GetAllocMemSize: function: Integer;
    _GetAllocMemCount: function: Integer;
  end;

function _GetAllocMemCount: Integer;
var
  State: TMemoryManagerState;
  i: Integer;
begin
  GetMemoryManagerState(State);
  Result := 0;
  for i := 0 to High(State.SmallBlockTypeStates) do
    Inc(Result, State.SmallBlockTypeStates[i].AllocatedBlockCount);
  Inc(Result, State.AllocatedMediumBlockCount + State.AllocatedLargeBlockCount);
end;

function _GetAllocMemSize: Integer;
var
  State: TMemoryManagerState;
  i: Integer;
begin
  GetMemoryManagerState(State);
  Result := 0;
  for i := 0 to High(State.SmallBlockTypeStates) do
    Inc(Result, State.SmallBlockTypeStates[i].AllocatedBlockCount *
      State.SmallBlockTypeStates[i].UseableBlockSize);
  Inc(Result, State.TotalAllocatedMediumBlockSize +
    State.TotalAllocatedLargeBlockSize);
end;

var
  wc: TWndClassA;
  IsHost: Boolean;
  ShareMem: TFastShareMem;

initialization
  if not GetClassInfoA(HInstance, ClassName, wc) then
  begin
    GetMemoryManager(ShareMem.MemoryManager);
    ShareMem._GetAllocMemCount := @_GetAllocMemCount;
    ShareMem._GetAllocMemSize := @_GetAllocMemSize;
    GetAllocMemCount := @_GetAllocMemCount;
    GetAllocMemSize := @_GetAllocMemSize;

    FillChar(wc, SizeOf(wc), 0);
    wc.lpszClassName := ClassName;
    wc.style := CS_GLOBALCLASS;
    wc.hInstance := HInstance;
    wc.lpfnWndProc := @ShareMem;

    if RegisterClassA(wc) = 0 then
    begin
      MessageBox(0, 'Shared Memory Allocator setup failed: Cannot register class.',
        'FastShareMem', 0);
      Halt;
    end;

    IsHost := True;
  end else begin
    SetMemoryManager(TFastShareMem(wc.lpfnWndProc^).MemoryManager);
    GetAllocMemCount := TFastShareMem(wc.lpfnWndProc^)._GetAllocMemCount;
    GetAllocMemSize := TFastShareMem(wc.lpfnWndProc^)._GetAllocMemSize;
    IsHost := False;
  end;
finalization
  if IsHost then
    UnregisterClassA(ClassName, HInstance);
end.