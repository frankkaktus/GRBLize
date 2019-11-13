object FormToolChange: TFormToolChange
  Left = 0
  Top = 0
  Caption = 'ToolChange'
  ClientHeight = 174
  ClientWidth = 390
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
    Left = 21
    Top = 24
    Width = 92
    Height = 23
    Caption = 'Is machine'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object LabelZeroed: TLabel
    Left = 122
    Top = 24
    Width = 64
    Height = 23
    Caption = 'zeroed'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 194
    Top = 24
    Width = 168
    Height = 23
    Caption = 'with next used tool?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object LabelDescription: TLabel
    Left = 11
    Top = 57
    Width = 169
    Height = 33
    Alignment = taCenter
    Caption = 'DESCRIPTION'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object BtnNoChange: TSpeedButton
    Left = 11
    Top = 112
    Width = 110
    Height = 50
    Caption = 'Yes (no change)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = BtnNoChangeClick
  end
  object BtnYes: TSpeedButton
    Left = 139
    Top = 113
    Width = 110
    Height = 50
    Caption = 'Yes'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = BtnYesClick
  end
  object BtnCancel: TSpeedButton
    Left = 267
    Top = 113
    Width = 110
    Height = 50
    Caption = 'Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = BtnCancelClick
  end
end
