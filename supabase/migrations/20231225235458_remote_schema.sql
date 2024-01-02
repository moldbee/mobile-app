alter table "public"."services_prices" drop constraint "services_prices_pkey";

drop index if exists "public"."services_prices_pkey";

drop table "public"."services_prices";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.create_new_user_profile()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$BEGIN
  INSERT INTO public.profiles (email, uid, role)
  VALUES (NEW.email, NEW.id, 3);
  RETURN NEW;
END;$function$
;


