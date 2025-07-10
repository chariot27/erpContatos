# ERPContatos

**ERPContatos** é uma aplicação desktop desenvolvida em **Delphi** com foco em gerenciamento básico de contatos. O sistema permite a visualização, inclusão, edição, exclusão e filtragem de registros de forma prática e eficiente.

## 🚀 Funcionalidades Principais

- 🔍 **Filtros por campo individual**  
  Pesquise rapidamente registros com base em qualquer um dos seguintes campos:
  - `ID`
  - `Nome`
  - `Telefone`
  - `Email`
  - `Ativo`

- ➕ **Adição de contatos**  
  Interface intuitiva para cadastrar novos contatos.

- ✏️ **Atualização de registros**  
  Edite as informações de um contato existente com apenas alguns cliques.

- ❌ **Exclusão de registros**  
  Remova contatos do sistema de forma segura.

- 🔢 **Contador de registros**  
  Exibição dinâmica da quantidade total de registros exibidos na grid.

## 🛠️ Tecnologias Utilizadas

- **Delphi** (VCL)
- **FireDAC** (para conexão com banco de dados)
- **SQLite / Firebird / outro** (dependendo da configuração do seu projeto)
- Componentes nativos VCL: `TEdit`, `TComboBox`, `TButton`, `TDBGrid`, `TLabel`, etc.

## 📷 Interface

A interface principal conta com:

- Grid de listagem (`TDBGrid`) para visualização dos contatos.
- ComboBox de filtros que permite selecionar qual campo deseja aplicar o filtro.
- Caixa de texto para entrada do valor a ser filtrado.
- Botões de ação: **Novo**, **Editar**, **Excluir**, **Filtrar** e **Limpar**.
- Rodapé com contador de registros.

