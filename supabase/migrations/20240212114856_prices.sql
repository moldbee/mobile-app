create table "public"."services_prices" (
    "id" bigint generated by default as identity not null,
    "created_at" timestamp with time zone not null default now(),
    "title_ru" text,
    "title_ro" text,
    "price" text,
    "service" bigint
);


CREATE UNIQUE INDEX services_prices_pkey ON public.services_prices USING btree (id);

alter table "public"."services_prices" add constraint "services_prices_pkey" PRIMARY KEY using index "services_prices_pkey";

alter table "public"."services_prices" add constraint "services_prices_service_fkey" FOREIGN KEY (service) REFERENCES services(id) not valid;   

alter table "public"."services_prices" validate constraint "services_prices_service_fkey";

grant delete on table "public"."services_prices" to "anon";

grant insert on table "public"."services_prices" to "anon";

grant references on table "public"."services_prices" to "anon";

grant select on table "public"."services_prices" to "anon";

grant trigger on table "public"."services_prices" to "anon";

grant truncate on table "public"."services_prices" to "anon";

grant update on table "public"."services_prices" to "anon";

grant delete on table "public"."services_prices" to "authenticated";

grant insert on table "public"."services_prices" to "authenticated";

grant references on table "public"."services_prices" to "authenticated";

grant select on table "public"."services_prices" to "authenticated";

grant trigger on table "public"."services_prices" to "authenticated";

grant truncate on table "public"."services_prices" to "authenticated";

grant update on table "public"."services_prices" to "authenticated";

grant delete on table "public"."services_prices" to "service_role";

grant insert on table "public"."services_prices" to "service_role";

grant references on table "public"."services_prices" to "service_role";

grant select on table "public"."services_prices" to "service_role";

grant trigger on table "public"."services_prices" to "service_role";

grant truncate on table "public"."services_prices" to "service_role";

grant update on table "public"."services_prices" to "service_role";