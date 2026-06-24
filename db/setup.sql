-- =============================================
-- SecondMind Full Database Setup
-- Run this ONCE in the InsForge SQL Editor
-- =============================================

-- 1. USERS TABLE (must be created first — other tables reference it)
create table if not exists public.users (
  id uuid primary key references auth.users(id) on delete cascade,
  email text,
  name text,
  avatar_url text,
  auth_provider text not null default 'google',
  phone text,
  integrations jsonb not null default '{}',
  dashboard_brief jsonb,
  last_login_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.users enable row level security;

grant select, insert, update on public.users to authenticated;

do $$
begin
  if not exists (
    select 1 from pg_policies
    where schemaname = 'public' and tablename = 'users' and policyname = 'Users can read own record'
  ) then
    create policy "Users can read own record"
      on public.users for select to authenticated
      using (auth.uid() = id);
  end if;

  if not exists (
    select 1 from pg_policies
    where schemaname = 'public' and tablename = 'users' and policyname = 'Users can insert own record'
  ) then
    create policy "Users can insert own record"
      on public.users for insert to authenticated
      with check (auth.uid() = id);
  end if;

  if not exists (
    select 1 from pg_policies
    where schemaname = 'public' and tablename = 'users' and policyname = 'Users can update own record'
  ) then
    create policy "Users can update own record"
      on public.users for update to authenticated
      using (auth.uid() = id)
      with check (auth.uid() = id);
  end if;
end $$;


-- 2. BRIEFING SCHEDULES TABLE
create table if not exists public.briefing_schedules (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.users(id) on delete cascade,
  name text not null,
  description text not null default '',
  apps text[] not null default '{}',
  categories text[] not null default '{}',
  scheduled_time text not null,
  frequency text not null default 'daily',
  priority_level text not null default 'medium',
  next_run_at timestamptz not null default now(),
  status text not null default 'active',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.briefing_schedules enable row level security;

grant select, insert, update, delete on public.briefing_schedules to authenticated;

do $$
begin
  if not exists (
    select 1 from pg_policies
    where schemaname = 'public' and tablename = 'briefing_schedules' and policyname = 'Users can manage own briefing schedules'
  ) then
    create policy "Users can manage own briefing schedules"
      on public.briefing_schedules for all to authenticated
      using (auth.uid() = user_id)
      with check (auth.uid() = user_id);
  end if;
end $$;


-- 3. GENERATED BRIEFINGS TABLE
create table if not exists public.generated_briefings (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.users(id) on delete cascade,
  schedule_id uuid references public.briefing_schedules(id) on delete set null,
  title text not null,
  summary text not null default '',
  stats jsonb not null default '{}',
  data jsonb not null default '{}',
  created_at timestamptz not null default now()
);

alter table public.generated_briefings enable row level security;

grant select, insert on public.generated_briefings to authenticated;

do $$
begin
  if not exists (
    select 1 from pg_policies
    where schemaname = 'public' and tablename = 'generated_briefings' and policyname = 'Users can manage own generated briefings'
  ) then
    create policy "Users can manage own generated briefings"
      on public.generated_briefings for all to authenticated
      using (auth.uid() = user_id)
      with check (auth.uid() = user_id);
  end if;
end $$;


-- 4. ALERT RULES TABLE
create table if not exists public.alert_rules (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.users(id) on delete cascade,
  name text not null,
  description text not null default '',
  apps text[] not null default '{}',
  condition text not null,
  priority text not null default 'medium' check (priority in ('high', 'medium', 'low')),
  notification_method text not null default 'in_app',
  frequency text not null default 'real_time',
  action text not null default 'notify',
  status text not null default 'active' check (status in ('active', 'paused', 'archived')),
  next_check_at timestamptz not null default now(),
  last_checked_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.alert_rules enable row level security;

grant select, insert, update, delete on public.alert_rules to authenticated;

do $$
begin
  if not exists (
    select 1 from pg_policies
    where schemaname = 'public' and tablename = 'alert_rules' and policyname = 'Users can read own alert rules'
  ) then
    create policy "Users can read own alert rules"
      on public.alert_rules for select to authenticated
      using (auth.uid() = user_id);
  end if;

  if not exists (
    select 1 from pg_policies
    where schemaname = 'public' and tablename = 'alert_rules' and policyname = 'Users can insert own alert rules'
  ) then
    create policy "Users can insert own alert rules"
      on public.alert_rules for insert to authenticated
      with check (auth.uid() = user_id);
  end if;

  if not exists (
    select 1 from pg_policies
    where schemaname = 'public' and tablename = 'alert_rules' and policyname = 'Users can update own alert rules'
  ) then
    create policy "Users can update own alert rules"
      on public.alert_rules for update to authenticated
      using (auth.uid() = user_id)
      with check (auth.uid() = user_id);
  end if;
end $$;


-- 5. ALERTS TABLE
create table if not exists public.alerts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.users(id) on delete cascade,
  rule_id uuid references public.alert_rules(id) on delete set null,
  dedupe_key text,
  title text not null,
  description text not null default '',
  full_details text not null default '',
  source_app text not null,
  app_logo text,
  priority text not null default 'medium' check (priority in ('high', 'medium', 'low')),
  status text not null default 'triggered' check (status in ('active', 'triggered', 'resolved', 'snoozed')),
  condition text not null default '',
  requires_response boolean not null default false,
  suggested_action text not null default '',
  last_action text,
  snoozed_until timestamptz,
  triggered_at timestamptz not null default now(),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create unique index if not exists alerts_dedupe_key_idx
  on public.alerts (dedupe_key)
  where dedupe_key is not null;

create index if not exists alert_rules_user_status_next_check_idx
  on public.alert_rules (user_id, status, next_check_at);

create index if not exists alerts_user_created_idx
  on public.alerts (user_id, created_at desc);

alter table public.alerts enable row level security;

grant select, insert, update on public.alerts to authenticated;

do $$
begin
  if not exists (
    select 1 from pg_policies
    where schemaname = 'public' and tablename = 'alerts' and policyname = 'Users can read own alerts'
  ) then
    create policy "Users can read own alerts"
      on public.alerts for select to authenticated
      using (auth.uid() = user_id);
  end if;

  if not exists (
    select 1 from pg_policies
    where schemaname = 'public' and tablename = 'alerts' and policyname = 'Users can insert own alerts'
  ) then
    create policy "Users can insert own alerts"
      on public.alerts for insert to authenticated
      with check (auth.uid() = user_id);
  end if;

  if not exists (
    select 1 from pg_policies
    where schemaname = 'public' and tablename = 'alerts' and policyname = 'Users can update own alerts'
  ) then
    create policy "Users can update own alerts"
      on public.alerts for update to authenticated
      using (auth.uid() = user_id)
      with check (auth.uid() = user_id);
  end if;
end $$;
