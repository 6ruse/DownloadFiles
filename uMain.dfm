object FrmExample: TFrmExample
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'FrmExample'
  ClientHeight = 139
  ClientWidth = 465
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lblStatus: TLabel
    Left = 8
    Top = 107
    Width = 41
    Height = 13
    Caption = 'lblStatus'
  end
  object edtURL: TEdit
    Left = 8
    Top = 8
    Width = 441
    Height = 21
    TabOrder = 0
    Text = 'edtURL'
  end
  object edtSavePath: TEdit
    Left = 8
    Top = 35
    Width = 441
    Height = 21
    TabOrder = 1
    Text = 'edtSavePath'
  end
  object btnDownload: TButton
    Left = 336
    Top = 102
    Width = 113
    Height = 25
    Caption = 'btnDownload'
    TabOrder = 2
    OnClick = btnDownloadClick
  end
  object edtFileName: TEdit
    Left = 8
    Top = 62
    Width = 441
    Height = 21
    TabOrder = 3
    Text = 'edtSavePath'
  end
end
