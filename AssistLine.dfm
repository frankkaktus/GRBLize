object FormAssistLine: TFormAssistLine
  Left = 0
  Top = 0
  Caption = 'FormAssistLine'
  ClientHeight = 264
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 239
    Top = 27
    Width = 46
    Height = 23
    Caption = '[mm]'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 239
    Top = 64
    Width = 46
    Height = 23
    Caption = '[mm]'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 239
    Top = 101
    Width = 23
    Height = 23
    Caption = '['#176']'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 239
    Top = 138
    Width = 46
    Height = 23
    Caption = '[mm]'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object LabelP0: TLabel
    Left = 39
    Top = 27
    Width = 20
    Height = 23
    Caption = 'P0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object LabelP1: TLabel
    Left = 39
    Top = 64
    Width = 20
    Height = 23
    Caption = 'P1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object LabelAngle: TLabel
    Left = 39
    Top = 101
    Width = 55
    Height = 23
    Caption = 'Winkel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object LabelLength: TLabel
    Left = 39
    Top = 138
    Width = 51
    Height = 23
    Caption = 'L'#228'nge'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object EditP0X: TEdit
    Left = 112
    Top = 24
    Width = 60
    Height = 31
    Alignment = taRightJustify
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Text = '0,0'
    OnExit = OnChangeP0
  end
  object EditP0Y: TEdit
    Left = 177
    Top = 24
    Width = 60
    Height = 31
    Alignment = taRightJustify
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    Text = '0,0'
    OnExit = OnChangeP0
  end
  object EditP1X: TEdit
    Left = 112
    Top = 61
    Width = 60
    Height = 31
    Alignment = taRightJustify
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    Text = '100,0'
    OnExit = OnChangeP1
  end
  object EditP1Y: TEdit
    Left = 177
    Top = 61
    Width = 60
    Height = 31
    Alignment = taRightJustify
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    Text = '0,0'
    OnExit = OnChangeP1
  end
  object EditAngle: TEdit
    Left = 112
    Top = 98
    Width = 125
    Height = 31
    Alignment = taRightJustify
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    Text = '0,0'
    OnExit = OnChangeAngle
  end
  object EditLength: TEdit
    Left = 112
    Top = 135
    Width = 125
    Height = 31
    Alignment = taRightJustify
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    Text = '100,0'
    OnExit = OnChangeLength
  end
  object ButtonOK: TButton
    Left = 175
    Top = 189
    Width = 110
    Height = 40
    Caption = 'OK'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    OnClick = ButtonOKClick
  end
  object ButtonCancel: TButton
    Left = 39
    Top = 189
    Width = 110
    Height = 40
    Caption = 'Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    OnClick = ButtonCancelClick
  end
  object TouchKeyboard1: TTouchKeyboard
    Left = 320
    Top = 8
    Width = 300
    Height = 250
    GradientEnd = clSilver
    GradientStart = clGray
    Layout = 'NumPad'
  end
end