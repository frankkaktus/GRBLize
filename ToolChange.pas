unit ToolChange;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls;

type
  TFormToolChange = class(TForm)
    Label1: TLabel;
    LabelZeroed: TLabel;
    Label3: TLabel;
    LabelDescription: TLabel;
    BtnNoChange: TSpeedButton;
    BtnYes: TSpeedButton;
    BtnCancel: TSpeedButton;
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnYesClick(Sender: TObject);
    procedure BtnNoChangeClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    function ShowModal(zeroed, NoChange: boolean; Pen: string):integer; reintroduce;
  end;

var
  FormToolChange: TFormToolChange;

implementation

{$R *.dfm}

procedure TFormToolChange.BtnCancelClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TFormToolChange.BtnNoChangeClick(Sender: TObject);
begin
  ModalResult:= mrNo;
end;

procedure TFormToolChange.BtnYesClick(Sender: TObject);
begin
  ModalResult:= mrYes;
end;

function TFormToolChange.ShowModal(zeroed, NoChange: boolean; Pen: string):integer;
begin
  if zeroed then LabelZeroed.Caption:= 'zeroed'
            else LabelZeroed.Caption:= 'loaded';
  BtnNoChange.Visible:= NoChange;
  LabelDescription.Caption:= Pen;
  Result:= inherited ShowModal;
end;

end.


