# katyFestaAuth

### Visão geral
- ANO: 2024/1
- OBJETIVO: O **KatyFestaAuth** é uma POC para aplicar o serviço dO FireBase Authentication.
- CONCLUSAO: Com algumas implementação prévia, percebe-se a necessidade de utilziar um padrão de projeto mais robusto, flutter_moular(injeção de depedência) e flutter_bloc(gerenciamento de estado) ao inves do Provider.

# Screen
- Valida de Imput: Impout vazio e Imput Invalido
- Validação de Login (Email e Senha) - Sucesso, Erro, Senha Incorreta.
- Validação de Cadastro (Email e Senha) - Sucesso , Erro, Usuário já Cadastrado.
- Validação de Cadastro com Google - Sucesso, Erro, Usuário já Cadastrado.
  
![login](https://github.com/ClaudioMarzo/flutter_auth_frebase/assets/78761536/1c188741-41ab-4b5d-9fb4-9261f587baec)

# Instalação e Configuração 

## Instalação do Flutter, siga os passos abaixo:

1. **Download do Flutter**: Acesse o [link](https://docs.flutter.dev/get-started/install/windows/desktop?tab=download) e extraia o SDK para o diretório raiz (`Disco Local (C:)`).

2. **Adicione ao Path**: Adicione o caminho `C:\flutter\bin` às variáveis de ambiente do sistema. Veja como fazer [aqui](https://support.microsoft.com/pt-br/topic/como-gerenciar-vari%C3%A1veis-de-ambiente-no-windows-xp-5bf6725b-655e-151c-0b55-9a8c9c7f747d#:~:text=Para%20exibir%20ou%20alterar%20vari%C3%A1veis,Clique%20em%20Vari%C3%A1veis%20de%20ambiente.).

3. **Execução**: No prompt de comando em modo administrador, execute `flutter doctor` para verificar o que está faltando para executar o Flutter. A ideia é que o resultado seja semelhante a este:

## Configuração do FireBase, siga os passos abaixo:

1. **Instação do CLI do FireBase**. Antes de tudo instale o [Node.js](https://nodejs.org/en), e seguir as intruções dessa documentação [doc de instação](https://firebase.google.com/docs/cli?hl=pt-br&_gl=1*b799wj*_up*MQ..&gclid=9a9cd9fddf4a16eb17e4bc1b970215f2&gclsrc=3p.ds#install-cli-windows) e depois siga esses passos caso dê erro na leitura de package [link](https://firebase.google.com/docs/flutter/setup?hl=pt-br&_gl=1*1vzbbh*_up*MQ..&gclid=9a9cd9fddf4a16eb17e4bc1b970215f2&gclsrc=3p.ds&platform=web).

#### **Observação: Para ter acesso a conta do FireBase entre em contato com o autor do projeto ou para mais informações**


## Build da Aplicação

Após baixar o repositório [KatyFestasCatalog
](https://github.com/ClaudioMarzo/KatyFestasCatalog.git), execute os seguintes comandos:

### Reconstrução do Projeto
- `flutter clean`
- `flutter build web`
- `flutter run`

### Instalando dependências:
- `flutter pub get`

### Atualizando dependências:
- `flutter pub upgrade`

### Verificando atualização de dependências:
- `flutter pub outdated`

