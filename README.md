# Controle de Cargas FLV

Aplicação estática para cadastro e consulta de cargas. O estado pode ser compartilhado entre operadores usando Supabase Realtime; sem configuração do Supabase, o sistema continua usando o armazenamento local do navegador.

## Configurar Supabase Free

1. Crie um projeto gratuito em https://supabase.com.
2. Abra o **SQL Editor** e execute todo o conteúdo de `supabase-schema.sql`.
3. Em **Project Settings > API**, copie a URL do projeto e a chave pública `anon`.
4. Edite `supabase-config.js`:

```javascript
window.FLV_SUPABASE_CONFIG = {
  url: "https://seu-projeto.supabase.co",
  anonKey: "sua-chave-anon-publica"
};
```

A chave `anon` pode ficar no frontend. Nunca coloque uma `service_role key` neste arquivo.

## Publicar no GitHub Pages

O ponto mais importante: o GitHub Pages só carrega automaticamente na URL principal um arquivo chamado **exatamente `index.html`**. Por isso o app deve ser commitado com esse nome (não `controle_cargas_flv.html`).

1. Crie um repositório **público** no GitHub. No plano gratuito, o GitHub Pages não funciona em repositório privado.
2. Instale o Git for Windows, se ainda não estiver instalado.
3. Na pasta do projeto, garanta que os arquivos estão com estes nomes exatos:
   - `index.html` (o HTML da aplicação, renomeado)
   - `.gitignore`
   - `.nojekyll` (arquivo vazio — evita que o GitHub tente processar o site como Jekyll e ignore pastas/arquivos que comecem com `_`)
   - `supabase-config.js`
   - `supabase-schema.sql`
   - `README.md`

   No Windows, o Explorer não deixa criar um arquivo começando com ponto direto pela interface. Use o PowerShell na pasta do projeto:

   ```powershell
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
git branch -M main
git remote add origin https://github.com/SEU_USUARIO/SEU_REPOSITORIO.git
git push -u origin main
```

5. No GitHub, abra **Settings > Pages**.
6. Selecione **Deploy from a branch**, branch `main` e pasta `/ (root)**`, e salve.
7. Aguarde 1–2 minutos. A própria tela de **Settings > Pages** mostra uma faixa verde "Your site is live at ..." com o link quando terminar. Se continuar sem aparecer depois de alguns minutos, veja a aba **Actions** do repositório — ela mostra o log da publicação e aponta o erro, se houver.
8. Acesse a URL informada pelo GitHub Pages (algo como `https://SEU_USUARIO.github.io/SEU_REPOSITORIO/`).

### Se o site continuar não aparecendo

- Confirme que o arquivo no repositório se chama `index.html` (não `controle_cargas_flv.html`) — sem isso, a URL raiz não mostra nada.
- Confirme que o repositório está **público**.
- Confirme em **Settings > Pages** que a branch/pasta selecionadas batem com onde os arquivos foram enviados.
- Teste acessar `https://SEU_USUARIO.github.io/SEU_REPOSITORIO/index.html` direto — se isso funcionar mas a URL sem `/index.html` não, o problema é o nome do arquivo.

## Observações

- Os operadores devem abrir a URL do GitHub Pages, não o arquivo via `file://`.
- O botão de backup Excel continua disponível.
- A tabela compartilhada usa um estado único; alterações muito simultâneas seguem a última gravação recebida.
- Para uso externo ou com dados sensíveis, recomenda-se adicionar autenticação e políticas RLS por usuário.
