unit Unit1_Contatos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, Vcl.Grids,
  Vcl.DBGrids, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    DBGrid1: TDBGrid;
    txtPesquisa: TEdit;
    cbFiltros: TComboBox;
    Button1: TButton;
    lblCount: TLabel;
    btnPesquisa: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure txtPesquisaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
  private // ✅ Declarado corretamente
    procedure ConfigurarColunasGrid;
  public
    DataSource1: TDataSource;
  end;

var
  Form1: TForm1;

implementation

uses Unit2_Manutencao;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Self.Position := poScreenCenter;

  // Criar SaveDialog dinamicamente
  //SaveDialog1 := TSaveDialog.Create(Self);

  // Configurar a conexão
  FDConnection1.LoginPrompt := False;
  FDConnection1.DriverName := 'SQLite';
  FDConnection1.Params.Database := 'C:\Users\noname\Documents\Databases\testedb.sqlite';
  FDConnection1.Connected := True;

  // Definir a query com CAST para evitar WideMemo
  FDQuery1.Connection := FDConnection1;
  FDQuery1.SQL.Text :=
    'SELECT ' +
    'ID, ' +
    'CAST(Nome AS VARCHAR(20)) AS nome, ' +
    'CAST(Telefone AS VARCHAR(20)) AS telefone, ' +
    'CAST(Email AS VARCHAR(100)) AS email, ' +
    'Ativo ' +
    'FROM contato';
  FDQuery1.Active := True;
  lblCount.Caption := 'Número de contatos: ' + FDQuery1.RecordCount.ToString;

  // Criar e configurar DataSource
  DataSource1 := TDataSource.Create(Self);
  DataSource1.DataSet := FDQuery1;
  DBGrid1.DataSource := DataSource1;

  // Ajustar colunas do Grid
  ConfigurarColunasGrid;
end;

procedure TForm1.txtPesquisaClick(Sender: TObject);
begin
  txtPesquisa.Text := '';
end;

procedure TForm1.btnPesquisaClick(Sender: TObject);
var
  whatFilter, SQL: string;
begin
  whatFilter := cbFiltros.Text;

  SQL :=
    'SELECT ' +
    'ID, ' +
    'CAST(Nome AS VARCHAR(20)) AS nome, ' +
    'CAST(Telefone AS VARCHAR(20)) AS telefone, ' +
    'CAST(Email AS VARCHAR(100)) AS email, ' +
    'Ativo ' +
    'FROM contato ';

  FDQuery1.Close;
  FDQuery1.SQL.Clear;
  FDQuery1.Connection := FDConnection1;

  if whatFilter.StartsWith('I') then
  begin
    SQL := SQL + 'WHERE ID = :id';
    FDQuery1.SQL.Text := SQL;
    FDQuery1.ParamByName('id').AsInteger := StrToIntDef(txtPesquisa.Text, 0);
  end
  else if whatFilter.StartsWith('N') then
  begin
    SQL := SQL + 'WHERE Nome LIKE :nome';
    FDQuery1.SQL.Text := SQL;
    FDQuery1.ParamByName('nome').AsString := '%' + txtPesquisa.Text + '%';
  end
  else if whatFilter.StartsWith('F') then
  begin
    SQL := SQL + 'WHERE Telefone LIKE :telefone';
    FDQuery1.SQL.Text := SQL;
    FDQuery1.ParamByName('telefone').AsString := '%' + txtPesquisa.Text + '%';
  end
  else if whatFilter.StartsWith('E') then
  begin
    SQL := SQL + 'WHERE Email LIKE :email';
    FDQuery1.SQL.Text := SQL;
    FDQuery1.ParamByName('email').AsString := '%' + txtPesquisa.Text + '%';
  end
  else if whatFilter.StartsWith('A') then
  begin
    SQL := SQL + 'WHERE Ativo = :ativo';
    FDQuery1.SQL.Text := SQL;
    FDQuery1.ParamByName('ativo').AsInteger := StrToIntDef(txtPesquisa.Text, 0);
  end
  else
  begin
    FDQuery1.SQL.Text := SQL;
  end;

  FDQuery1.Open;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  f2: TForm2;
begin
  f2 := TForm2.Create(Self);
  f2.cbModo.Text := 'Adição';
  try
    f2.ShowModal;
  finally
    f2.Free;
  end;
end;

procedure TForm1.ConfigurarColunasGrid;
begin
  DBGrid1.Columns.Clear;

  with DBGrid1.Columns.Add do
  begin
    FieldName := 'ID';
    Title.Caption := 'ID';
    Width := 50;
    Alignment := taCenter;
  end;

  with DBGrid1.Columns.Add do
  begin
    FieldName := 'nome';
    Title.Caption := 'Nome';
    Width := 150;
  end;

  with DBGrid1.Columns.Add do
  begin
    FieldName := 'telefone';
    Title.Caption := 'Telefone';
    Width := 100;
  end;

  with DBGrid1.Columns.Add do
  begin
    FieldName := 'email';
    Title.Caption := 'Email';
    Width := 200;
  end;

  with DBGrid1.Columns.Add do
  begin
    FieldName := 'ativo';
    Title.Caption := 'Ativo';
    Width := 50;
    Alignment := taCenter;
  end;
end;

procedure TForm1.DBGrid1DblClick(Sender: TObject);
var
  f2: TForm2;
begin
  f2 := TForm2.Create(Self);
  f2.cbModo.Text := 'Manutenção';
  try
    f2.ShowModal;
  finally
    f2.Free;
  end;
end;

end.

