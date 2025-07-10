object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'GEST'#195'O DE CONTATOS'
  ClientHeight = 371
  ClientWidth = 776
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object lblCount: TLabel
    Left = 599
    Top = 340
    Width = 143
    Height = 15
    Caption = 'N'#250'mero de contato: {num}'
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 56
    Width = 577
    Height = 307
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
  end
  object txtPesquisa: TEdit
    Left = 96
    Top = 27
    Width = 393
    Height = 23
    TabOrder = 1
    Text = 'Pesquisar aqui...'
    OnClick = txtPesquisaClick
  end
  object cbFiltros: TComboBox
    Left = 8
    Top = 27
    Width = 82
    Height = 23
    TabOrder = 2
    Text = 'Nome'
    Items.Strings = (
      'ID'
      'Nome'
      'Telefone'
      'Email'
      'Ativo')
  end
  object Button1: TButton
    Left = 591
    Top = 56
    Width = 177
    Height = 25
    Caption = 'Adicionar'
    TabOrder = 3
    OnClick = Button1Click
  end
  object btnPesquisa: TButton
    Left = 495
    Top = 27
    Width = 90
    Height = 23
    Caption = 'Pesquisar'
    TabOrder = 4
    OnClick = btnPesquisaClick
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'DriverID=SQLite')
    Connected = True
    Left = 712
    Top = 312
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 712
    Top = 256
  end
end
