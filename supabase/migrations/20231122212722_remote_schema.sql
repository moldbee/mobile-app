alter table "public"."events" drop column "link";

alter table "public"."events" drop column "paid";

alter table "public"."events" add column "price" text;


