unit AssistLine;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.Math,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Touch.Keyboard, import_files;

type
  TModel = (ModelPP, ModelPAL);

type
  TFormAssistLine = class(TForm)
    EditP0X: TEdit;
    EditP0Y: TEdit;
    EditP1X: TEdit;
    EditP1Y: TEdit;
    EditAngle: TEdit;
    EditLength: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    LabelAngle: TLabel;
    LabelLength: TLabel;
    ButtonOK: TButton;
    ButtonCancel: TButton;
    TouchKeyboard1: TTouchKeyboard;
    ButtonP0Cam: TSpeedButton;
    ButtonP1Cam: TSpeedButton;
    procedure OnChangeP0(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
    procedure OnChangeP1(Sender: TObject);
    procedure OnChangeAngle(Sender: TObject);
    procedure OnChangeLength(Sender: TObject);
    procedure ButtonP1CamClick(Sender: TObject);
    procedure ButtonP0CamClick(Sender: TObject);
    procedure OnKeyPress(Sender: TObject; var Key: Char);
//    procedure FormShow(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    P0:     TPointFloat;
    P1:     TPointFloat;
    Angle:  double;
    Length: double;
    function ShowModal(Row: integer):integer; reintroduce;
    function GetID:string;
  end;

var
  FormAssistLine: TFormAssistLine;

implementation

{$R *.dfm}

uses grbl_player_main, SelectPosition, ParamAssist;

procedure TFormAssistLine.ButtonCancelClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TFormAssistLine.ButtonOKClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TFormAssistLine.ButtonP0CamClick(Sender: TObject);
begin
  if FormSelectPosition.ShowModal(P0) = mrOK then begin
    EditP0X.Text:= FormSelectPosition.WPosX.Caption;
    EditP0Y.Text:= FormSelectPosition.WPosY.Caption;
    OnChangeP0(nil);
  end;
end;

procedure TFormAssistLine.ButtonP1CamClick(Sender: TObject);
begin
  if FormSelectPosition.ShowModal(P1) = mrOK then begin
    EditP1X.Text:= FormSelectPosition.WPosX.Caption;
    EditP1Y.Text:= FormSelectPosition.WPosY.Caption;
    OnChangeP1(nil);
  end;
end;

procedure TFormAssistLine.OnKeyPress(Sender: TObject; var Key: Char);
begin
  if CharInSet(Key, [#27]) then ButtonCancelClick(Sender);
end;

function TFormAssistLine.ShowModal(Row: integer):integer;
begin
  P0:= FileParamArray[Row-1].P0;
  P1:= FileParamArray[Row-1].P1;

  EditP0X.Text:= FormatFloat('0.0',P0.X);
  EditP0Y.Text:= FormatFloat('0.0',P0.Y);
  EditP1X.Text:= FormatFloat('0.0',P1.X);
  EditP1Y.Text:= FormatFloat('0.0',P1.Y);
  Length:= sqrt( (P1.x-P0.x)*(P1.x-P0.x) + (P1.y-P0.y)*(P1.y-P0.y) );
  EditLength.Text:= FormatFloat('0.0',Length);
  Angle:= arcsin( (P1.y-P0.y) / Length );
  EditAngle.Text:= FormatFloat('0.00',Angle*180/Pi);
  if Form1.TouchSupport then Width:= 620                     // touch supported?
                        else Width:= 310;

  Result:= inherited ShowModal;

  if Result = mrOK then begin
    FileParamArray[Row-1].P0:= P0;
    FileParamArray[Row-1].P1:= P1;
  end;
end;

function TFormAssistLine.GetId:string;
begin
  GetId:= 'Line [(' + FormatFloat('0.0',P0.X) + ';' +
                      FormatFloat('0.0',P0.Y) + '),(' +
                      FormatFloat('0.0',P1.X) + ';' +
                      FormatFloat('0.0',P1.Y) + ')]';
end;

procedure TFormAssistLine.OnChangeAngle(Sender: TObject);
begin
  Angle:= Pi / 180 * StrToFloatDef(EditAngle.Text, Angle);
  EditAngle.Text:= FormatFloat('0.00',Angle*180/Pi);

  P1.x:= P0.x + (length * cos(angle));
  P1.y:= P0.y + (length * sin(angle));
  EditP1X.Text:= FormatFloat('0.0',P1.X);
  EditP1Y.Text:= FormatFloat('0.0',P1.Y);
end;

procedure TFormAssistLine.OnChangeLength(Sender: TObject);
begin
  Length:= StrToFloatDef(EditLength.Text, Length);
  EditLength.Text:= FormatFloat('0.0',Length);

  P1.x:= P0.X + (length * cos(angle));
  P1.y:= P0.Y + (length * sin(angle));
  EditP1X.Text:= FormatFloat('0.0',P1.x);
  EditP1Y.Text:= FormatFloat('0.0',P1.y);
end;

procedure TFormAssistLine.OnChangeP0(Sender: TObject);
var Pold: TPointFloat;
begin
  Pold:= P0;
  P0.x:= StrToFloatDef(EditP0X.Text, P0.x);
  P0.y:= StrToFloatDef(EditP0Y.Text, P0.y);
  EditP0X.Text:= FormatFloat('0.0',P0.x);
  EditP0Y.Text:= FormatFloat('0.0',P0.y);

  P1.x:= P1.x - Pold.x + P0.x;
  P1.y:= P1.y - Pold.y + P0.y;
  EditP1X.Text:= FormatFloat('0.0',P1.x);
  EditP1Y.Text:= FormatFloat('0.0',P1.y);

  Length:= sqrt( (P1.x-P0.x)*(P1.x-P0.x) + (P1.y-P0.y)*(P1.y-P0.y) );
  EditLength.Text:= FormatFloat('0.0',Length);

  Angle:= arcsin( (P1.y-P0.y) / Length );
  EditAngle.Text:= FormatFloat('0.00',Angle*180/Pi);
end;

procedure TFormAssistLine.OnChangeP1(Sender: TObject);
begin
  P1.x:= StrToFloatDef(EditP1X.Text, P1.x);
  P1.y:= StrToFloatDef(EditP1Y.Text, P1.y);
  EditP1X.Text:= FormatFloat('0.0',P1.x);
  EditP1Y.Text:= FormatFloat('0.0',P1.y);

  Length:= sqrt( (P1.x-P0.x)*(P1.x-P0.x) + (P1.y-P0.y)*(P1.y-P0.y) );
  EditLength.Text:= FormatFloat('0.0',Length);

  Angle:= arcsin( (P1.y-P0.y) / Length );
  EditAngle.Text:= FormatFloat('0.00',Angle*180/Pi);
end;

end.


