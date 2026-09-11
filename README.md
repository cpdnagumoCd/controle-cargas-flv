# Controle de Cargas FLV

Aplicação estática para cadastro e consulta de cargas. O estado pode ser compartilhado entre operadores usando Firebase (Cloud Firestore) em tempo real; sem configuração do Firebase, o sistema continua usando o armazenamento local do navegador.

## Configurar o Firebase (Cloud Firestore)

1. Acesse https://console.firebase.google.com e crie um projeto (pode ser no plano gratuito **Spark**).
2. No menu lateral, abra **Build → Firestore Database** e clique em **Criar banco de dados**. Escolha uma região próxima (ex.: `southamerica-east1`) e inicie em **modo de produção**.
3. Ainda no Firestore, vá na aba **Regras** e cole o conteúdo do arquivo `firestore.rules` deste pacote, substituindo o que já estiver lá. Clique em **Publicar**.
   - Essas regras deixam o banco aberto para leitura e escrita, sem login — o mesmo modelo de confiança que o app já usava. Para uso externo ou com dados sensíveis, adicione autenticação e regras por usuário.
4. Volte em **Configurações do projeto** (ícone de engrenagem) → aba **Geral** → role até "Seus apps" → clique no ícone `</>` (Web) para registrar um app web. Não precisa marcar "Firebase Hosting".
5. O Firebase vai mostrar um bloco `firebaseConfig` parecido com este:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSy...",
  authDomain: "seu-projeto.firebaseapp.com",
  projectId: "seu-projeto",
  storageBucket: "seu-projeto.firebasestorage.app",
  messagingSenderId: "123456789",
  appId: "1:123456789:web:abcdef"
};
```

6. Copie esses valores para o arquivo `firebase-config.js` deste pacote:

```javascript
window.FLV_FIREBASE_CONFIG = {
  apiKey: "AIzaSy...",
  authDomain: "seu-projeto.firebaseapp.com",
  projectId: "seu-projeto",
  storageBucket: "seu-projeto.firebasestorage.app",
  messagingSenderId: "123456789",
  appId: "1:123456789:web:abcdef"
};
```

Essas chaves são feitas para ficar no frontend (não são secretas como uma chave de servidor) — a segurança real vem das regras do Firestore do passo 3.

### Como os dados ficam organizados

- Cada carga vira **um documento** na coleção `cargas` (identificado pelo mesmo ID interno do app). Editar ou excluir uma carga só grava/apaga o documento dela — não reescreve as outras.
- A lista de fornecedores fica num único documento em `meta/fornecedores`.

### Migrando os dados que já existem

Se você já tem cargas cadastradas (vindas do armazenamento local ou do Supabase antigo):

1. **Antes de trocar de versão do app**, use o menu "Backup ▾ → Baixar planilha agora" para exportar tudo em `.xlsx`.
2. Publique esta nova versão (com o Firebase já configurado).
3. Abra o app e use "Backup ▾ → Importar planilha", selecionando o arquivo baixado no passo 1. A importação **mescla** os dados (não duplica nada já existente) e isso vai gravar cada carga no Firestore, populando o banco novo.

## Publicar no GitHub Pages

<<<<<<< HEAD
1. Crie um repositório **público** no GitHub. No plano gratuito, o GitHub Pages não funciona em repositório privado.
2. Garanta que os arquivos estão com estes nomes exatos na raiz do repositório:
   - `index.html` (o HTML da aplicação)
   - `.gitignore`
   - `.nojekyll` (arquivo vazio — evita que o GitHub tente processar o site como Jekyll)
   - `firebase-config.js`
   - `firestore.rules` (só de referência — as regras de verdade ficam no console do Firebase, não neste arquivo)
=======
O ponto mais importante: o GitHub Pages só carrega automaticamente na URL principal um arquivo chamado **exatamente `index.html`**. Por isso o app deve ser commitado com esse nome (não `controle_cargas_flv.html`).

1. Crie um repositório **público** no GitHub. No plano gratuito, o GitHub Pages não funciona em repositório privado.
2. Instale o Git for Windows, se ainda não estiver instalado.
3. Na pasta do projeto, garanta que os arquivos estão com estes nomes exatos:
   - `index.html` (o HTML da aplicação, renomeado)
   - `.gitignore`
   - `.nojekyll` (arquivo vazio — evita que o GitHub tente processar o site como Jekyll e ignore pastas/arquivos que comecem com `_`)
   - `supabase-config.js`
   - `supabase-schema.sql`
>>>>>>> c373a137b384e61a0411a4d58030789efe4f05cd
   - `README.md`

   No Windows, o Explorer não deixa criar um arquivo começando com ponto direto pela interface. Use o PowerShell na pasta do projeto:

   ```powershell
<<<<<<< HEAD
   New-Item .gitignore -ItemType File -Force
   New-Item .nojekyll -ItemType File -Force
   ```

3. Execute:

```powershell
git init
git add index.html .gitignore .nojekyll firebase-config.js firestore.rules README.md
git commit -m "Publicar aplicacao com Firebase"
=======
   Rename-Item controle_cargas_flv.html index.html
   New-Item .gitignore -ItemType File -Force
   Set-Content .gitignore "backup_cargas_FLV.xlsx"
   New-Item .nojekyll -ItemType File -Force
   ```

4. Execute:

```powershell
git init
git add index.html .gitignore .nojekyll supabase-config.js supabase-schema.sql README.md
git commit -m "Publicar aplicacao com Supabase"
>>>>>>> c373a137b384e61a0411a4d58030789efe4f05cd
git branch -M main
git remote add origin https://github.com/SEU_USUARIO/SEU_REPOSITORIO.git
git push -u origin main
```

<<<<<<< HEAD
4. No GitHub, abra **Settings > Pages**.
5. Selecione **Deploy from a branch**, branch `main` e pasta `/ (root)`, e salve.
6. Aguarde 1–2 minutos. A própria tela de **Settings > Pages** mostra uma faixa verde "Your site is live at ..." com o link quando terminar.
7. Acesse a URL informada pelo GitHub Pages (algo como `https://SEU_USUARIO.github.io/SEU_REPOSITORIO/`).

### Se o site continuar não aparecendo

- Confirme que o arquivo no repositório se chama `index.html` — sem isso, a URL raiz não mostra nada.
- Confirme que o repositório está **público**.
- Confirme em **Settings > Pages** que a branch/pasta selecionadas batem com onde os arquivos foram enviados.
=======
5. No GitHub, abra **Settings > Pages**.
6. Selecione **Deploy from a branch**, branch `main` e pasta `/ (root)**`, e salve.
7. Aguarde 1–2 minutos. A própria tela de **Settings > Pages** mostra uma faixa verde "Your site is live at ..." com o link quando terminar. Se continuar sem aparecer depois de alguns minutos, veja a aba **Actions** do repositório — ela mostra o log da publicação e aponta o erro, se houver.
8. Acesse a URL informada pelo GitHub Pages (algo como `https://SEU_USUARIO.github.io/SEU_REPOSITORIO/`).

### Se o site continuar não aparecendo

- Confirme que o arquivo no repositório se chama `index.html` (não `controle_cargas_flv.html`) — sem isso, a URL raiz não mostra nada.
- Confirme que o repositório está **público**.
- Confirme em **Settings > Pages** que a branch/pasta selecionadas batem com onde os arquivos foram enviados.
- Teste acessar `https://SEU_USUARIO.github.io/SEU_REPOSITORIO/index.html` direto — se isso funcionar mas a URL sem `/index.html` não, o problema é o nome do arquivo.
>>>>>>> c373a137b384e61a0411a4d58030789efe4f05cd

## Observações

- Os operadores devem abrir a URL do GitHub Pages, não o arquivo via `file://`.
- O botão de backup Excel continua disponível no menu "Backup ▾" no cabeçalho.
- Cada carga sincroniza de forma independente; alterações muito simultâneas na mesma carga seguem a última gravação recebida.
- Para uso externo ou com dados sensíveis, recomenda-se adicionar autenticação (Firebase Auth) e regras de segurança por usuário no lugar das regras abertas do passo 3.
