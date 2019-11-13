unit SelectPosition;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.Buttons,
  CntrCam, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TFormSelectPosition = class(TForm)
    OkButton: TSpeedButton;
    CancelButton: TSpeedButton;
    Bevel1: TBevel;
    WPosX: TLabel;
    Label8: TLabel;
    ZPosX: TLabel;
    WPosY: TLabel;
    Label17: TLabel;
    ZPosY: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    MPosX: TLabel;
    MPosY: TLabel;
    procedure OkButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    count: integer;
    { Public-Deklarationen }
    CntrBox: TCntrBox;
    constructor Create(AOwner: TComponent); override;
    function ShowModal(P: TPointFloat):integer; reintroduce;
  end;

var
  FormSelectPosition: TFormSelectPosition;

implementation

{$R *.dfm}

uses grbl_player_main,
     import_files;

///// FormSelectPosition ///////////////////////////////////////////////////////

procedure TFormSelectPosition.CancelButtonClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

constructor TFormSelectPosition.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  CntrBox:=             TCntrBox.Create(self);
  CntrBox.Parent:=      self;
  CntrBox.Name:=        'MillCntrBox';
  CntrBox.Caption:=     '';
  CntrBox.Height:=      resHeight;
  CntrBox.Width:=       resWidth;
  CntrBox.FOnMillCntr:= Form1.HndlMillCntr;
end;

procedure TFormSelectPosition.OkButtonClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

function TFormSelectPosition.ShowModal(P: TPointFloat):integer;
var x, y: double;
begin
  x:= P.x + WorkZero.x;
  y:= P.y + WorkZero.y;
  if iCamControl.CamState = camActive then begin
    x:= x - job.cam_x;
    y:= y - job.cam_y;
  end;
  SendSingleCommandStr('G0 G53 X' + FloatToSTrDot(x) +
                             ' Y' + FloatToSTrDot(y));
  result:= inherited ShowModal;
end;

end.


