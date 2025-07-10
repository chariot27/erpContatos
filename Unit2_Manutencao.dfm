object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'MANUTEN'#199#195'O DE CONTATOS'
  ClientHeight = 194
  ClientWidth = 307
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object txtID: TEdit
    Left = 250
    Top = 16
    Width = 49
    Height = 23
    TabStop = False
    Enabled = False
    TabOrder = 0
    Text = 'ID'
    OnChange = txtIDChange
    OnClick = txtIDClick
  end
  object txtName: TEdit
    Left = 8
    Top = 45
    Width = 291
    Height = 23
    TabOrder = 1
    Text = 'Nome'
    OnClick = txtNameClick
  end
  object txtFone: TEdit
    Left = 8
    Top = 74
    Width = 291
    Height = 23
    TabOrder = 2
    Text = 'Telefone'
    OnClick = txtFoneClick
  end
  object cbModo: TComboBox
    Left = 8
    Top = 16
    Width = 236
    Height = 23
    Enabled = False
    TabOrder = 3
    Text = 'Manuten'#231#227'o'
    Items.Strings = (
      'Manuten'#231#227'o'
      'Adi'#231#227'o')
  end
  object txtEmail: TEdit
    Left = 8
    Top = 103
    Width = 291
    Height = 23
    TabOrder = 4
    Text = 'Email'
    OnClick = txtEmailClick
  end
  object txtAtivo: TEdit
    Left = 8
    Top = 132
    Width = 41
    Height = 23
    TabOrder = 5
    Text = '1'
    OnClick = txtAtivoClick
  end
  object btnExec: TButton
    Left = 55
    Top = 132
    Width = 244
    Height = 25
    Caption = 'Executar'
    TabOrder = 6
    OnClick = btnExecClick
  end
  object btnExcluir: TButton
    Left = 55
    Top = 161
    Width = 244
    Height = 25
    Caption = 'Excluir'
    TabOrder = 7
    OnClick = btnExcluirClick
  end
  object FDQuery1: TFDQuery
    Left = 288
    Top = 65528
  end
end
