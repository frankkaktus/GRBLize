unit AssistRect;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.Math,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Touch.Keyboard, import_files, Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TFormAssistRect = class(TForm)
    EditP0X: TEdit;
    EditP0Y: TEdit;
    EditP1X: TEdit;
    EditP1Y: TEdit;
    EditWidth: TEdit;
    EditHeight: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    LabelWidth: TLabel;
    LabelHight: TLabel;
    ButtonOK: TButton;
    ButtonCancel: TButton;
    TouchKeyboard1: TTouchKeyboard;
    ButtonP0: TButton;
    ButtonP1: TButton;
    Image1: TImage;
    procedure OnChangeP0(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
    procedure OnChangeP1(Sender: TObject);
    procedure OnChangeWidth(Sender: TObject);
    procedure OnChangeHeight(Sender: TObject);
//    procedure FormShow(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    P0:     TPointFloat;
    P1:     TPointFloat;
    Width:  double;
    Height: double;
    function ShowModal(Row: integer):integer; reintroduce;
    function GetID:string;
  end;

var
  FormAssistRect: TFormAssistRect;

implementation

{$R *.dfm}

uses grbl_player_main;

procedure TFormAssistRect.ButtonCancelClick(Sender: TObject);
begin
  FormAssistRect.ModalResult:= mrCancel;
end;

procedure TFormAssistRect.ButtonOKClick(Sender: TObject);
begin
  FormAssistRect.ModalResult:= mrOK;
end;

function TFormAssistRect.ShowModal(Row: integer):integer;
begin
  P0:= FileParamArray[Row-1].P0;
  P1:= FileParamArray[Row-1].P1;

  EditP0X.Text:= FormatFloat('0.0',P0.X);
  EditP0Y.Text:= FormatFloat('0.0',P0.Y);
  EditP1X.Text:= FormatFloat('0.0',P1.X);
  EditP1Y.Text:= FormatFloat('0.0',P1.Y);
  Width:= P1.x - P0.x;
  EditWidth.Text:= FormatFloat('0.0',Width);
  Height:= P1.y - P0.y;
  EditHeight.Text:= FormatFloat('0.0',Height);
  if Form1.TouchSupport then Width:= 690                           // touch supported?
                        else Width:= 380;

  Result:= inherited ShowModal;

  if Result = mrOK then begin
    FileParamArray[Row-1].P0:= P0;
    FileParamArray[Row-1].P1:= P1;
  end;
end;

function TFormAssistRect.GetId:string;
begin
  GetId:= 'Rect [(' + FormatFloat('0.0',P0.X) + ';' +
                      FormatFloat('0.0',P0.Y) + '),(' +
                      FormatFloat('0.0',P1.X) + ';' +
                      FormatFloat('0.0',P1.Y) + ')]';
end;

{procedure TFormAssistRect.FormShow(Sender: TObject);
begin
  EditP0X.Text:= FormatFloat('0.0',P0.X);
  EditP0Y.Text:= FormatFloat('0.0',P0.Y);
  EditP1X.Text:= FormatFloat('0.0',P1.X);
  EditP1Y.Text:= FormatFloat('0.0',P1.Y);
  Length:= sqrt( (P1.x-P0.x)*(P1.x-P0.x) + (P1.y-P0.y)*(P1.y-P0.y) );
  EditLength.Text:= FormatFloat('0.0',Length);
  Angle:= arcsin( (P1.y-P0.y) / Length );
  EditAngle.Text:= FormatFloat('0.00',Angle*180/Pi);
  if Form1.TouchSupport then Width:= 690                           // touch supported?
                        else Width:= 380;
end;
 }
procedure TFormAssistRect.OnChangeWidth(Sender: TObject);
begin
  Width:= StrToFloatDef(EditWidth.Text, Width);
  EditWidth.Text:= FormatFloat('0.0',Width);

  P1.x:= P0.x + Width;
  EditP1X.Text:= FormatFloat('0.0',P1.x);
end;

procedure TFormAssistRect.OnChangeHeight(Sender: TObject);
begin
  Height:= StrToFloatDef(EditHeight.Text, Height);
  EditHeight.Text:= FormatFloat('0.0',Height);

  P1.y:= P0.Y + Height;
  EditP1Y.Text:= FormatFloat('0.0',P1.y);
end;

procedure TFormAssistRect.OnChangeP0(Sender: TObject);
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

//  Width:= P1.x - P0.x;
//  EditWidth.Text:= FormatFloat('0.0',Width);
//  Height:= P1.y - P0.y;
//  EditHeight.Text:= FormatFloat('0.0',Height);
end;

procedure TFormAssistRect.OnChangeP1(Sender: TObject);
begin
  P1.x:= StrToFloatDef(EditP1X.Text, P1.x);
  P1.y:= StrToFloatDef(EditP1Y.Text, P1.y);
  EditP1X.Text:= FormatFloat('0.0',P1.x);
  EditP1Y.Text:= FormatFloat('0.0',P1.y);

  Width:= P1.x - P0.x;
  EditWidth.Text:= FormatFloat('0.0',Width);
  Height:= P1.y - P0.y;
  EditHeight.Text:= FormatFloat('0.0',Height);
end;

end.


