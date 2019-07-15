object FormGerber: TFormGerber
  Left = 227
  Top = 108
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSizeToolWin
  BorderWidth = 4
  Caption = 'Convert Gerber to GCode'
  ClientHeight = 523
  ClientWidth = 790
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnPaint = FormPaint
  DesignSize = (
    790
    523)
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBox1: TPaintBox
    Left = 0
    Top = 0
    Width = 789
    Height = 406
    Anchors = [akLeft, akTop, akRight, akBottom]
    Color = clSilver
    ParentColor = False
  end
  object Memo2: TMemo
    Left = 236
    Top = 413
    Width = 437
    Height = 109
    Anchors = [akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object OKBtn: TButton
    Left = 679
    Top = 472
    Width = 110
    Height = 50
    Hint = 'Accept plot and import to GRBLize files'
    Anchors = [akTop, akRight]
    Caption = 'OK'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 1
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnClick = OKBtnClick
  end
  object CancelBtn: TButton
    Left = 679
    Top = 413
    Width = 110
    Height = 50
    Anchors = [akTop, akRight]
    Cancel = True
    Caption = 'Abbrechen'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ModalResult = 2
    ParentFont = False
    TabOrder = 1
    OnClick = CancelBtnClick
  end
  object InflateGroup: TGroupBox
    Left = 0
    Top = 407
    Width = 230
    Height = 55
    Caption = 'Inflate (mm)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    object InflateBar: TTrackBar
      Left = 80
      Top = 12
      Width = 144
      Height = 40
      DragKind = dkDock
      Max = 20
      Position = 2
      TabOrder = 0
      ThumbLength = 40
      TickStyle = tsNone
      OnChange = InflateBarChange
    end
    object EditInflate: TEdit
      Left = 5
      Top = 17
      Width = 70
      Height = 32
      Hint = 'Offset to track/pad outline'
      Alignment = taCenter
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Text = '0,2'
      OnEnter = ShowTouchKeyboard
      OnExit = InflateEditExit
      OnKeyPress = EditInflateKeyPress
    end
  end
  object PCBBox: TGroupBox
    Left = 0
    Top = 467
    Width = 230
    Height = 55
    TabOrder = 4
    object Label1: TLabel
      Left = 5
      Top = 2
      Width = 68
      Height = 13
      Caption = 'PCB Thickness'
    end
    object Label2: TLabel
      Left = 155
      Top = 2
      Width = 69
      Height = 13
      Caption = 'Outline ZCycle'
    end
    object Label3: TLabel
      Left = 80
      Top = 2
      Width = 52
      Height = 13
      Caption = 'Outline Dia'
    end
    object ComboThickness: TComboBox
      Left = 5
      Top = 17
      Width = 70
      Height = 31
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = '1,6'
      TextHint = 'Thickness of PCB'
      Items.Strings = (
        '0,4'
        '0,6'
        '0,8'
        '1,2'
        '1,6'
        '2,0'
        '2,4')
    end
  end
  object EditDimDia: TEdit
    Left = 80
    Top = 484
    Width = 70
    Height = 31
    Hint = 'Offset to track/pad outline'
    Alignment = taCenter
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    Text = '0,2'
    OnEnter = ShowTouchKeyboard
    OnExit = HideTouchKeyboard
    OnKeyPress = EditDimDiaKeyPress
  end
  object EditZCycle: TEdit
    Left = 155
    Top = 484
    Width = 70
    Height = 31
    Hint = 'Offset to track/pad outline'
    Alignment = taCenter
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    Text = '0,2'
    OnEnter = ShowTouchKeyboard
    OnExit = HideTouchKeyboard
    OnKeyPress = EditZCycleKeyPress
  end
  object TouchKeyboard: TTouchKeyboard
    Left = 8
    Top = 136
    Width = 255
    Height = 255
    GradientEnd = clSilver
    GradientStart = clGray
    Layout = 'NumPad'
  end
  object TimerInflateBar: TTimer
    Enabled = False
    Interval = 10
    OnTimer = InflateBarTimer
    Left = 40
    Top = 32
  end
end
