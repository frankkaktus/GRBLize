unit CntrBox;

interface

uses
  VFrames,
  StdCtrls,
  ExtCtrls,
  Windows,
  Messages,
  Controls,
  Graphics,
  Classes;

const
  WM_POINTERDOWN = $0246;
  WM_POINTERUP   = $0247;

type
  TCntrBox = class(TCustomControl)
    private
    protected
      procedure WMPointerDown(var Msg: TMessage); message WM_POINTERDOWN;
      procedure WMPointerUp(var Msg: TMessage); message WM_POINTERUP;
    public
      FOnTouchDown:  TMouseEvent;
      FOnTouchUp:    TMouseEvent;
      fCamPresent:   boolean;                            // Kamera ist vorhanden
      fCamActivated: boolean;                            // Kamera ist aktiviert
      CamIsOn:       boolean;                 // Kamera ist gerade eingeschaltet
      fVideoImage:   TVideoImage;                                 // Videodevice
      fVideoBitmap:  TBitmap;
      VideoBox:      TPaintBox;
      Title:         TLabel;
      Overlay_Color: TColor;
      Diameter:      integer;
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      procedure OnNewVideoFrame(Sender : TObject; Width, Height: integer; DataPtr: pointer);

// Set/Get Overlay_Color
// Set/Get Diameter

    published
      property OnTouchDown: TMouseEvent read FOnTouchDown write FOnTouchDown;
      property OnTouchUp:   TMouseEvent read FOnTouchUp   write FOnTouchUp;
  end;

implementation

constructor TCntrBox.Create(AOwner: TComponent);
var DeviceList: TStringList;

begin
  inherited Create(AOwner);

  Title:= TLabel.Create(self);

  DeviceList := TStringList.Create;
  fVideoImage.GetListOfDevices(DeviceList);

  if DeviceList.Count < 1 then begin
    // If no camera has been found, terminate program
    fCamPresent:= false;
    DeviceList.Free;
    Title.Caption:='No Webcam/Video Device found';
    CamIsOn:= false;
  end else begin
    fCamPresent:= true;

    VideoBox:= TPaintBox.Create(self);

    // Create instance of our video image class.
    fVideoImage:= TVideoImage.Create;
    // Tell fVideoImage where to paint the images it receives from the camera
    // (Only in case we do not want to modify the images by ourselves)
    fVideoImage.SetDisplayCanvas(VideoBox.Canvas);
    fVideoBitmap:= TBitmap.create;
    fVideoBitmap.Height:= VideoBox.Height;
    fVideoBitmap.Width:= VideoBox.Width;

    fVideoImage.OnNewVideoFrame := OnNewVideoFrame;
    Title.Caption:='  Webcam/Video Device off';

//    OldEvent:= RadioGroupCam.OnClick;                      // save OnClick event
//    RadioGroupCam.OnClick:= nil;                // no execution of OnClick event
//    RadioGroupCam.ItemIndex:= 0;
//    if CamIsOn then
//      RadioGroupCam.ItemIndex:= 1;
//    RadioGroupCam.OnClick := OldEvent;                  // restore OnClick event
  end;


  end;

destructor TCntrBox.Destroy;
begin
  inherited Destroy;
end;

procedure TCntrBox.WMPointerDown(var Msg: TMessage);
var Shift:  TShiftState;
begin
  if assigned(FOnTouchDown) then FOnTouchDown(Self, mbLeft, Shift, 0, 0);
  Msg.Result := DefWindowProc(Handle, Msg.Msg, Msg.WParam, Msg.LParam);
end;

procedure TCntrBox.WMPointerUp(var Msg: TMessage);
var Shift:  TShiftState;
begin
  if assigned(FOnTouchUp) then FOnTouchUp(Self, mbLeft, Shift, 0, 0);
  Msg.Result := DefWindowProc(Handle, Msg.Msg, Msg.WParam, Msg.LParam);
end;

procedure TCntrBox.OnNewVideoFrame(Sender : TObject; Width, Height: integer; DataPtr: pointer);
var
  r : integer;
  bm_center_x, bm_center_y: Integer;
  bm: TBitMap;
begin
  // Retreive latest video image
  if not fCamActivated then exit;
  fVideoImage.GetBitmap(fVideoBitmap);
  with fVideoBitmap do begin
    // Paint a crosshair onto video image
    bm_center_x:= VideoBox.width div 2;
    bm_center_y:= VideoBox.height div 2;
    Canvas.Brush.Style := bsClear;
    Canvas.Pen.Width   := 1;
    Canvas.Pen.Color:= Overlay_Color;
    Canvas.moveto(0, bm_center_y);
    Canvas.lineto(Width,  bm_center_y);
    Canvas.moveto(bm_center_x, 0);
    Canvas.lineto(bm_center_x, Height);
//    r := (VideoBox.height * TrackBar1.Position div 256);
    Canvas.ellipse(bm_center_x - Diameter, bm_center_y - Diameter,
        bm_center_x + Diameter, bm_center_y + Diameter);
    VideoBox.Canvas.Draw(0, 0, fVideoBitmap);
  end;
end;



end.

//======================================================================

procedure TForm1.Button1Click(Sender: TObject);
var
  Bitmap : TBitMap;
begin
  Bitmap := TBitmap.Create;
  try
    with Bitmap do begin
      LoadFromFile('factory.bmp');
      Transparent := True;
      TransParentColor := BitMap.canvas.pixels[50,50];
      Form1.Canvas.Draw(0,0,BitMap);
      TransparentMode := tmAuto;
      Form1.Canvas.Draw(50,50,BitMap);
    end;
  finally
    Bitmap.Free;
  end;
end;
