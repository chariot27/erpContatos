unit Unit2_Manutencao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Unit1_Contatos;

type
  TForm2 = class(TForm)
    txtID: TEdit;
    txtName: TEdit;
    txtFone: TEdit;
    cbModo: TComboBox;
    txtEmail: TEdit;
    txtAtivo: TEdit;
    btnExec: TButton;
    FDQuery1: TFDQuery;
    btnExcluir: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnExecClick(Sender: TObject);
    procedure txtIDClick(Sender: TObject);
    procedure txtNameClick(Sender: TObject);
    procedure txtEmailClick(Sender: TObject);
    procedure txtFoneClick(Sender: TObject);
    procedure txtAtivoClick(Sender: TObject);
    procedure txtIDChange(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.FormCreate(Sender: TObject);
begin
  Self.Position := poScreenCenter;
end;

procedure TForm2.FormShow(Sender: TObject);
var
  qry: TFDQuery;
  modo: string;
  proximoID, inputID: Integer;
begin
  modo := cbModo.Text;
  if modo.StartsWith('A') then // Adição
  begin
    qry := TFDQuery.Create(nil);
    try
      qry.Connection := Form1.FDConnection1;
      qry.SQL.Text := 'SELECT MAX(ID) AS ultimo_id FROM contato';
      qry.Open;

      proximoID := qry.FieldByName('ultimo_id').AsInteger + 1;
      if proximoID = 0 then
        proximoID := 1;

      txtID.Text := proximoID.ToString;
      txtID.Enabled := False;

    finally
      qry.Free;
    end;
  end
  else if modo.StartsWith('M') then // Manutenção
  begin
    txtID.Text := Form1.FDQuery1.FieldByName('ID').AsString;
  end;
end;

procedure TForm2.btnExcluirClick(Sender: TObject);
var
  qry: TFDQuery;
  modo: string;
  SQL: string;
begin
   modo := cbModo.Text;
   if modo.StartsWith('M') then
   begin
      btnExcluir.Enabled := True;
      SQL := 'DELETE FROM contato ' +
             'WHERE ID = :id';
      qry := TFDQuery.Create(nil);
      try
         qry.Connection := Form1.FDConnection1;
         qry.SQL.Text := SQL;

         qry.ParamByName('id').AsInteger := StrToIntDef(txtID.Text, 0);
         qry.ExecSQL;

         ShowMessage('Contato excluido com sucesso.');

         Form1.FDQuery1.Close;
         Form1.FDQuery1.Open;

         ModalResult := mrOk;
      finally
         qry.Free;

      end;
   end;
end;

procedure TForm2.btnExecClick(Sender: TObject);
var
  qry: TFDQuery;
  modo: string;
  SQL: string;
begin
  modo := cbModo.Text;
  if modo.StartsWith('A') then // Inserção
  begin
    SQL := 'INSERT INTO contato (ID, Nome, Telefone, Email, Ativo) ' +
           'VALUES (:id, :nome, :fone, :email, :ativo)';

    qry := TFDQuery.Create(nil);
    try
      qry.Connection := Form1.FDConnection1;
      qry.SQL.Text := SQL;

      qry.ParamByName('id').AsInteger := StrToIntDef(txtID.Text, 0);
      qry.ParamByName('nome').AsString := txtName.Text;
      qry.ParamByName('fone').AsString := txtFone.Text;
      qry.ParamByName('email').AsString := txtEmail.Text;
      qry.ParamByName('ativo').AsInteger := StrToIntDef(txtAtivo.Text, 0);

      qry.ExecSQL;

      ShowMessage('Contato adicionado com sucesso.');

      Form1.FDQuery1.Close;
      Form1.FDQuery1.Open;

      ModalResult := mrOk;
    finally
      qry.Free;
    end;
  end
  else if modo.StartsWith('M') then
  begin
    SQL := 'UPDATE contato SET ' +
       'Nome = :nome, ' +
       'Telefone = :fone, ' +
       'Email = :email, ' +
       'Ativo = :ativo ' +
       'WHERE ID = :id';


    qry := TFDQuery.Create(nil);
    try
      qry.Connection := Form1.FDConnection1;
      qry.SQL.Text := SQL;

      qry.ParamByName('id').AsInteger := StrToIntDef(txtID.Text, 0);
      qry.ParamByName('nome').AsString := txtName.Text;
      qry.ParamByName('fone').AsString := txtFone.Text;
      qry.ParamByName('email').AsString := txtEmail.Text;
      qry.ParamByName('ativo').AsInteger := StrToIntDef(txtAtivo.Text, 0);

      qry.ExecSQL;

      ShowMessage('Contato atualizado com sucesso.');

      Form1.FDQuery1.Close;
      Form1.FDQuery1.Open;

      ModalResult := mrOk;
    finally
      qry.Free;
    end;
  end;
end;

procedure TForm2.txtIDChange(Sender: TObject);
var
  qry: TFDQuery;
  inputID: Integer;
  idSelected: Integer;
begin

  // Só executa se o conteúdo não estiver vazio
  if Trim(txtID.Text) = '' then
    Exit;

  inputID := StrToIntDef(txtID.Text, -1);
  if inputID <= 0 then
  begin
    ShowMessage('ID inválido.');
    Exit;
  end;

  qry := TFDQuery.Create(nil);
  try
    qry.Connection := Form1.FDConnection1;
    qry.SQL.Text := 'SELECT ID AS id, Nome AS nome, Telefone AS fone, Email AS email, Ativo AS ativo FROM contato WHERE id = :id';
    qry.ParamByName('id').AsInteger := inputID;
    qry.Open;

    if not qry.IsEmpty then
    begin
      // Preenche os campos com os dados encontrados
      txtID.Text    := qry.FieldByName('id').AsString;
      txtName.Text  := qry.FieldByName('nome').AsString;
      txtFone.Text  := qry.FieldByName('fone').AsString;
      txtEmail.Text := qry.FieldByName('email').AsString;
      txtAtivo.Text := qry.FieldByName('ativo').AsString;
    end
    else
    begin
      //ShowMessage('Registro não encontrado.');
      txtName.Clear;
      txtFone.Clear;
      txtEmail.Clear;
      txtAtivo.Clear;
    end;

  finally
    qry.Free;
  end;
end;


procedure TForm2.txtIDClick(Sender: TObject);
begin
  txtID.Text := '';
end;

procedure TForm2.txtNameClick(Sender: TObject);
begin
  txtName.Text := '';
end;

procedure TForm2.txtEmailClick(Sender: TObject);
begin
  txtEmail.Text := '';
end;

procedure TForm2.txtFoneClick(Sender: TObject);
begin
  txtFone.Text := '';
end;

procedure TForm2.txtAtivoClick(Sender: TObject);
begin
  txtAtivo.Text := '';
end;

end.

