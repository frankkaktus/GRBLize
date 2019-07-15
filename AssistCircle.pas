unit AssistCircle;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.Math,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Touch.Keyboard, import_files, Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TFormAssistCircle = class(TForm)
    EditCX: TEdit;
    EditCY: TEdit;
    EditP1X: TEdit;
    EditP1Y: TEdit;
    EditRadius: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    LabelRadius: TLabel;
    ButtonOK: TButton;
    ButtonCancel: TButton;
    TouchKeyboard1: TTouchKeyboard;
    Image1: TImage;
    ButtonCenter: TButton;
    ButtonP1: TButton;
    procedure OnChangeP0(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
    procedure OnChangeP1(Sender: TObject);
    procedure OnChangeRadius(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    C:     TPointFloat;
    P1:     TPointFloat;
    Radius:  double;
    function ShowModal(Row: integer):integer; reintroduce;
    function GetID:string;
  end;

var
  FormAssistCircle: TFormAssistCircle;

implementation

{$R *.dfm}

uses grbl_player_main;

procedure TFormAssistCircle.ButtonCancelClick(Sender: TObject);
begin
  FormAssistCircle.ModalResult:= mrCancel;
end;

procedure TFormAssistCircle.ButtonOKClick(Sender: TObject);
begin
  FormAssistCircle.ModalResult:= mrOK;
end;

function TFormAssistCircle.ShowModal(Row: integer):integer;
begin
  C:= FileParamArray[Row-1].P0;
  P1:= FileParamArray[Row-1].P1;

  EditCX.Text:= FormatFloat('0.0',C.X);
  EditCY.Text:= FormatFloat('0.0',C.Y);
  EditP1X.Text:= FormatFloat('0.0',P1.X);
  EditP1Y.Text:= FormatFloat('0.0',P1.Y);
  Radius:= sqrt( (P1.x-C.x)*(P1.x-C.x) + (P1.y-C.y)*(P1.y-C.y) );
  EditRadius.Text:= FormatFloat('0.0',Radius);
  if Form1.TouchSupport then Width:= 690                           // touch supported?
                        else Width:= 380;

  Result:= inherited ShowModal;

  if Result = mrOK then begin
    FileParamArray[Row-1].P0:= C;
    FileParamArray[Row-1].P1:= P1;
  end;
end;

function TFormAssistCircle.GetId:string;
begin
  GetId:= 'Circle [(' + FormatFloat('0.0',C.x) + ';' +
                        FormatFloat('0.0',C.y) + '),(' +
                        FormatFloat('0.0',P1.x) + ';' +
                        FormatFloat('0.0',P1.y) + ')]';
end;

procedure TFormAssistCircle.OnChangeRadius(Sender: TObject);
var Rold: double;
begin
  Rold:= Radius;
  Radius:= StrToFloatDef(EditRadius.Text, Radius);
  EditRadius.Text:= FormatFloat('0.0',Radius);

  P1.x:= P1.x * Radius/Rold;
  P1.y:= P1.y * Radius/Rold;
  EditP1X.Text:= FormatFloat('0.0',P1.x);
  EditP1Y.Text:= FormatFloat('0.0',P1.y);
end;

procedure TFormAssistCircle.OnChangeP0(Sender: TObject);
var Cold: TPointFloat;
begin
  Cold:= C;
  C.x:= StrToFloatDef(EditCX.Text, C.x);
  C.y:= StrToFloatDef(EditCY.Text, C.y);
  EditCX.Text:= FormatFloat('0.0',C.x);
  EditCY.Text:= FormatFloat('0.0',C.y);

  P1.x:= P1.x - Cold.x + C.x;
  P1.y:= P1.y - Cold.y + C.y;
  EditP1X.Text:= FormatFloat('0.0',P1.x);
  EditP1Y.Text:= FormatFloat('0.0',P1.y);

//  Length:= sqrt( (P1.x-P0.x)*(P1.x-P0.x) + (P1.y-P0.y)*(P1.y-P0.y) );
//  EditLength.Text:= FormatFloat('0.0',Length);

//  Angle:= arcsin( (P1.y-P0.y) / Length );
//  EditAngle.Text:= FormatFloat('0.00',Angle*180/Pi);
end;

procedure TFormAssistCircle.OnChangeP1(Sender: TObject);
begin
  P1.x:= StrToFloatDef(EditP1X.Text, P1.x);
  P1.y:= StrToFloatDef(EditP1Y.Text, P1.y);
  EditP1X.Text:= FormatFloat('0.0',P1.x);
  EditP1Y.Text:= FormatFloat('0.0',P1.y);

  Radius:= sqrt( (P1.x-C.x)*(P1.x-C.x) + (P1.y-C.y)*(P1.y-C.y) );
  EditRadius.Text:= FormatFloat('0.0',Radius);

end;

end.


