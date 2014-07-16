object Form1: TForm1
  Left = 192
  Top = 116
  Width = 275
  Height = 213
  Caption = 'Ephem processing'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 13
    Top = 11
    Width = 30
    Height = 13
    Caption = #1044#1055#1058'1'
  end
  object Label2: TLabel
    Left = 208
    Top = 12
    Width = 30
    Height = 13
    Caption = #1044#1055#1058'2'
  end
  object Label3: TLabel
    Left = 131
    Top = 12
    Width = 6
    Height = 13
    Caption = '--'
  end
  object Label4: TLabel
    Left = 35
    Top = 44
    Width = 46
    Height = 13
    Caption = 'Max_mag'
  end
  object Label5: TLabel
    Left = 8
    Top = 73
    Width = 69
    Height = 13
    Caption = 'Min_Vazhnost'#39
  end
  object Button1: TButton
    Left = 168
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Select'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 56
    Top = 8
    Width = 65
    Height = 21
    TabOrder = 1
    Text = '85'
  end
  object Edit2: TEdit
    Left = 144
    Top = 8
    Width = 57
    Height = 21
    TabOrder = 2
    Text = '-40'
  end
  object Button2: TButton
    Left = 168
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Rename'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Edit3: TEdit
    Left = 85
    Top = 40
    Width = 41
    Height = 21
    TabOrder = 4
    Text = '15'
  end
  object Edit4: TEdit
    Left = 86
    Top = 69
    Width = 41
    Height = 21
    TabOrder = 5
    Text = '0'
  end
  object CheckBox1: TCheckBox
    Left = 24
    Top = 97
    Width = 89
    Height = 17
    Caption = 'Add satellites'
    TabOrder = 6
  end
  object Button3: TButton
    Left = 168
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Sort by Long'
    Enabled = False
    TabOrder = 7
    OnClick = Button3Click
  end
  object CheckBox2: TCheckBox
    Left = 24
    Top = 117
    Width = 73
    Height = 17
    Caption = 'no TLE'
    TabOrder = 8
  end
  object CheckBox3: TCheckBox
    Left = 24
    Top = 137
    Width = 57
    Height = 17
    Caption = 'P<800'
    TabOrder = 9
  end
  object CheckBox4: TCheckBox
    Left = 24
    Top = 158
    Width = 65
    Height = 17
    Caption = '40cm'
    TabOrder = 10
  end
  object OpenDialog1: TOpenDialog
    Left = 248
  end
end
