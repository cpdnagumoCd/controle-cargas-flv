create table if not exists public.flv_app_state (
  id text primary key,
  payload jsonb not null default '{"cargas":[],"fornecedores":[]}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.flv_app_state enable row level security;

create policy "FLV operators can read shared state"
  on public.flv_app_state for select
  to anon, authenticated
  using (true);

create policy "FLV operators can insert shared state"
  on public.flv_app_state for insert
  to anon, authenticated
  with check (true);

create policy "FLV operators can update shared state"
  on public.flv_app_state for update
  to anon, authenticated
  using (true)
  with check (true);

insert into public.flv_app_state (id, payload)
values ('main', '{"cargas":[],"fornecedores":[]}'::jsonb)
on conflict (id) do nothing;

alter publication supabase_realtime add table public.flv_app_state;
