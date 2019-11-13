object FormSelectPosition: TFormSelectPosition
  Left = 0
  Top = 0
  Caption = 'Select Position'
  ClientHeight = 560
  ClientWidth = 640
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 23
  object OkButton: TSpeedButton
    Left = 515
    Top = 495
    Width = 110
    Height = 50
    Caption = 'OK'
    OnClick = OkButtonClick
  end
  object CancelButton: TSpeedButton
    Left = 390
    Top = 495
    Width = 110
    Height = 50
    Caption = 'Abbruch'
    OnClick = CancelButtonClick
  end
  object Bevel1: TBevel
    Left = 0
    Top = 0
    Width = 640
    Height = 480
  end
  object WPosX: TLabel
    Left = 27
    Top = 480
    Width = 138
    Height = 53
    Alignment = taRightJustify
    Caption = '000,00'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -45
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label8: TLabel
    Left = 140
    Top = 528
    Width = 25
    Height = 13
    Caption = 'Zero:'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clDefault
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object ZPosX: TLabel
    Left = 120
    Top = 541
    Width = 45
    Height = 16
    Hint = 'Offset to part zero in machine coordinates'
    Caption = '000,00'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object WPosY: TLabel
    Left = 197
    Top = 480
    Width = 138
    Height = 53
    Alignment = taRightJustify
    Caption = '000,00'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -45
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label17: TLabel
    Left = 310
    Top = 528
    Width = 25
    Height = 13
    Caption = 'Zero:'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clDefault
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object ZPosY: TLabel
    Left = 290
    Top = 541
    Width = 45
    Height = 16
    Hint = 'Offset to part zero in machine coordinates'
    Caption = '000,00'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 27
    Top = 528
    Width = 44
    Height = 13
    Caption = 'Machine:'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clDefault
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Label2: TLabel
    Left = 197
    Top = 528
    Width = 44
    Height = 13
    Caption = 'Machine:'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clDefault
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object MPosX: TLabel
    Left = 27
    Top = 541
    Width = 45
    Height = 16
    Hint = 'Offset to part zero in machine coordinates'
    Caption = '000,00'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object MPosY: TLabel
    Left = 197
    Top = 541
    Width = 45
    Height = 16
    Hint = 'Offset to part zero in machine coordinates'
    Caption = '000,00'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
end
