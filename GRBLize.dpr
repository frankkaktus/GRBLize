program GRBLize;

{$R 'CntrMask64.res' 'CntrMask64.rc'}
{$R 'NumpadKeyboard.res' 'NumpadKeyboard.rc'}

uses
  Forms,
  ABOUT in 'ABOUT.PAS' {AboutBox},
  grbl_com in 'grbl_com.pas',
  blinklist in 'ftdiclass\blinklist.pas',
  bsearchtree in 'ftdiclass\bsearchtree.pas',
  FTDIchip in 'ftdiclass\FTDIchip.pas',
  FTDIdll in 'ftdiclass\FTDIdll.pas',
  FTDIthread in 'ftdiclass\FTDIthread.pas',
  FTDItypes in 'ftdiclass\FTDItypes.pas',
  deviceselect in 'deviceselect.pas' {deviceselectbox},
  clipper in 'clipper.pas',
  drawing_window in 'drawing_window.pas' {Form2},
  glscene_view in 'glscene_view.pas' {Form4},
  DirectDraw in 'DirectX\DirectDraw.pas',
  DirectShow9 in 'DirectX\DirectShow9.pas',
  DirectSound in 'DirectX\DirectSound.pas',
  DXTypes in 'DirectX\DXTypes.pas',
  Direct3D9 in 'DirectX\Direct3D9.pas',
  grbl_player_main in 'grbl_player_main.pas' {Form1},
  VFrames in 'VFrames.pas',
  gerber_import in 'gerber_import.pas' {FormGerber},
  import_files in 'import_files.pas',
  app_Defaults in 'app_Defaults.pas',
  Vcl.Themes,
  Vcl.Styles,
  ParamAssist in 'ParamAssist.pas' {FormParamAssist},
  AssistRect in 'AssistRect.pas' {FormAssistRect},
  AssistCircle in 'AssistCircle.pas' {FormAssistCircle},
  AssistLine in 'AssistLine.pas' {FormAssistLine},
  SelectPosition in 'SelectPosition.pas' {FormSelectPosition},
  CntrCam in 'CntrCam.pas',
  ToolChange in 'ToolChange.pas' {FormToolChange};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'GRBLize';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.CreateForm(TFormGerber, FormGerber);
  Application.CreateForm(TFormParamAssist, FormParamAssist);
  Application.CreateForm(TFormAssistRect, FormAssistRect);
  Application.CreateForm(TFormAssistCircle, FormAssistCircle);
  Application.CreateForm(TFormAssistLine, FormAssistLine);
  Application.CreateForm(TFormSelectPosition, FormSelectPosition);
  Application.CreateForm(TFormToolChange, FormToolChange);
  Form1.BeforeRun;
  NeedsRedraw:= true;

  Form1.VideoBox:=             TCntrBox.Create(Form1.TabSheetPos);
  Form1.VideoBox.Parent:=      Form1.TabSheetPos;
  Form1.VideoBox.Name:=        'MillVodeoBox';
  Form1.VideoBox.Caption:=     '';
  Form1.VideoBox.Height:=      resHeight;
  Form1.VideoBox.Width:=       resWidth;
  Form1.VideoBox.FOnMillCntr:= Form1.HndlMillCntr;

  Application.Run;
  Application.Terminate;
end.

// Abschalten des Überschreibens der visuellen Effekte durch das Windows-Theme
// https://stackoverflow.com/questions/4393723/how-to-switch-an-application-between-themed-and-not-themed-at-run-time
