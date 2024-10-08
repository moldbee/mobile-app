revoke delete on table "public"."services_alerts" from "anon";

revoke insert on table "public"."services_alerts" from "anon";

revoke references on table "public"."services_alerts" from "anon";

revoke select on table "public"."services_alerts" from "anon";

revoke trigger on table "public"."services_alerts" from "anon";

revoke truncate on table "public"."services_alerts" from "anon";

revoke update on table "public"."services_alerts" from "anon";

revoke delete on table "public"."services_alerts" from "authenticated";

revoke insert on table "public"."services_alerts" from "authenticated";

revoke references on table "public"."services_alerts" from "authenticated";

revoke select on table "public"."services_alerts" from "authenticated";

revoke trigger on table "public"."services_alerts" from "authenticated";

revoke truncate on table "public"."services_alerts" from "authenticated";

revoke update on table "public"."services_alerts" from "authenticated";

revoke delete on table "public"."services_alerts" from "service_role";

revoke insert on table "public"."services_alerts" from "service_role";

revoke references on table "public"."services_alerts" from "service_role";

revoke select on table "public"."services_alerts" from "service_role";

revoke trigger on table "public"."services_alerts" from "service_role";

revoke truncate on table "public"."services_alerts" from "service_role";

revoke update on table "public"."services_alerts" from "service_role";

alter table "public"."services_alerts" drop constraint "services_alerts_service_fkey";

alter table "public"."services_alerts" drop constraint "services_alerts_pkey";

drop index if exists "public"."services_alerts_pkey";

drop table "public"."services_alerts";

create table "public"."services_faqs" (
    "id" bigint generated by default as identity not null,
    "created_at" timestamp with time zone not null default now(),
    "question_ro" text,
    "question_ru" text,
    "answer_ro" text,
    "answer_ru" text,
    "service" bigint
);


CREATE UNIQUE INDEX services_faqs_pkey ON public.services_faqs USING btree (id);

alter table "public"."services_faqs" add constraint "services_faqs_pkey" PRIMARY KEY using index "services_faqs_pkey";        

alter table "public"."services_faqs" add constraint "services_faqs_service_fkey" FOREIGN KEY (service) REFERENCES services(id) not valid;

alter table "public"."services_faqs" validate constraint "services_faqs_service_fkey";

grant delete on table "public"."services_faqs" to "anon";

grant insert on table "public"."services_faqs" to "anon";

grant references on table "public"."services_faqs" to "anon";

grant select on table "public"."services_faqs" to "anon";

grant trigger on table "public"."services_faqs" to "anon";

grant truncate on table "public"."services_faqs" to "anon";

grant update on table "public"."services_faqs" to "anon";

grant delete on table "public"."services_faqs" to "authenticated";

grant insert on table "public"."services_faqs" to "authenticated";

grant references on table "public"."services_faqs" to "authenticated";

grant select on table "public"."services_faqs" to "authenticated";

grant trigger on table "public"."services_faqs" to "authenticated";

grant truncate on table "public"."services_faqs" to "authenticated";

grant update on table "public"."services_faqs" to "authenticated";

grant delete on table "public"."services_faqs" to "service_role";

grant insert on table "public"."services_faqs" to "service_role";

grant references on table "public"."services_faqs" to "service_role";

grant select on table "public"."services_faqs" to "service_role";

grant trigger on table "public"."services_faqs" to "service_role";

grant truncate on table "public"."services_faqs" to "service_role";

grant update on table "public"."services_faqs" to "service_role";