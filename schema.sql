-- À exécuter une seule fois dans l'éditeur SQL de Supabase.
create extension if not exists pgcrypto;

create table public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  first_name text not null default '', last_name text not null default '',
  phone text default '', role text not null default 'benevole' check (role in ('benevole','ca','admin')),
  active boolean not null default true, created_at timestamptz not null default now()
);
create table public.missions (id uuid primary key default gen_random_uuid(), name text not null, location text not null, manager text default '', instructions text default '', team text default '', created_at timestamptz default now());
create table public.shifts (id uuid primary key default gen_random_uuid(), volunteer_id uuid not null references public.profiles(id) on delete cascade, mission_id uuid not null references public.missions(id) on delete cascade, day date not null, starts time not null, ends time not null, note text default '', created_at timestamptz default now());
create table public.app_settings (id int primary key default 1 check(id=1), event_name text default 'Fête de la Rosière', whatsapp_community text default '', updated_at timestamptz default now());
insert into public.app_settings(id) values(1) on conflict do nothing;
create table public.parades (id uuid primary key default gen_random_uuid(), name text not null, day date not null, notes text default '', created_at timestamptz default now());
create table public.parade_items (id uuid primary key default gen_random_uuid(), parade_id uuid not null references public.parades(id) on delete cascade, label text not null, kind text not null default 'Association', manager text default '', phone text default '', color text default '#fff3b0', pos_x numeric not null default 40, pos_y numeric not null default 40, sort_order int default 0, notes text default '');

create or replace function public.my_role() returns text language sql stable security definer set search_path=public as $$ select role from public.profiles where id=auth.uid() $$;
create or replace function public.handle_new_user() returns trigger language plpgsql security definer set search_path=public as $$ begin insert into public.profiles(id,first_name,last_name,phone) values(new.id,coalesce(new.raw_user_meta_data->>'first_name',''),coalesce(new.raw_user_meta_data->>'last_name',''),coalesce(new.raw_user_meta_data->>'phone','')); return new; end $$;
create trigger on_auth_user_created after insert on auth.users for each row execute procedure public.handle_new_user();

alter table public.profiles enable row level security; alter table public.missions enable row level security; alter table public.shifts enable row level security; alter table public.app_settings enable row level security; alter table public.parades enable row level security; alter table public.parade_items enable row level security;
create policy profiles_read on public.profiles for select to authenticated using(active=true or id=auth.uid() or public.my_role() in ('ca','admin'));
create policy profiles_ca_all on public.profiles for all to authenticated using(public.my_role() in ('ca','admin')) with check(public.my_role() in ('ca','admin'));
create policy missions_read on public.missions for select to authenticated using(true); create policy missions_write on public.missions for all to authenticated using(public.my_role() in ('ca','admin')) with check(public.my_role() in ('ca','admin'));
create policy shifts_read on public.shifts for select to authenticated using(true); create policy shifts_write on public.shifts for all to authenticated using(public.my_role() in ('ca','admin')) with check(public.my_role() in ('ca','admin'));
create policy settings_read on public.app_settings for select to authenticated using(true); create policy settings_write on public.app_settings for all to authenticated using(public.my_role() in ('ca','admin')) with check(public.my_role() in ('ca','admin'));
create policy parades_ca on public.parades for all to authenticated using(public.my_role() in ('ca','admin')) with check(public.my_role() in ('ca','admin'));
create policy parade_items_ca on public.parade_items for all to authenticated using(public.my_role() in ('ca','admin')) with check(public.my_role() in ('ca','admin'));

-- Après votre première inscription, remplacez l'adresse puis exécutez :
-- update public.profiles set role='admin' where id=(select id from auth.users where email='votre@email.fr');
