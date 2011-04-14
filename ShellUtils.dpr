//****************************************************************************\\
//                                                                            \\
//  Shell Utilities plugin for SCAR Divi 3.2x                                 \\
//                                                                            \\
//  By Fr�d�ric Hannes                                                        \\
//                                                                            \\
//****************************************************************************\\
library ShellUtils;

{$R *.res}

uses
  FastShareMem in 'FastShareMem.pas',
  SCARFunctions in 'SCARFunctions.pas',
  ShellUtils_Globals in 'ShellUtils_Globals.pas',
  ShellUtils_Main in 'ShellUtils_Main.pas';

exports GetFunctionCount;
exports GetFunctionInfo;

end.

