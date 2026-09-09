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

1. Crie um repositório no GitHub.
2. Instale o Git for Windows, se ainda não estiver instalado.
3. Na pasta do projeto, execute:

```powershell
git init
git add controle_cargas_flv.html supabase-config.js supabase-schema.sql README.md
git commit -m "Adicionar sincronizacao Supabase"
git branch -M main
git remote add origin https://github.com/SEU_USUARIO/SEU_REPOSITORIO.git
git push -u origin main
```

4. No GitHub, abra **Settings > Pages**.
5. Selecione **Deploy from a branch**, branch `main` e pasta `/ (root)`.
6. Acesse a URL informada pelo GitHub Pages.

## Observações

- Os operadores devem abrir a URL do GitHub Pages, não o arquivo via `file://`.
- O botão de backup Excel continua disponível.
- A tabela compartilhada usa um estado único; alterações muito simultâneas seguem a última gravação recebida.
- Para uso externo ou com dados sensíveis, recomenda-se adicionar autenticação e políticas RLS por usuário.
