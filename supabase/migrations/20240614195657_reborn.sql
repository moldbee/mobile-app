revoke delete on table "public"."events" from "anon";

revoke insert on table "public"."events" from "anon";

revoke references on table "public"."events" from "anon";

revoke select on table "public"."events" from "anon";

revoke trigger on table "public"."events" from "anon";

revoke truncate on table "public"."events" from "anon";

revoke update on table "public"."events" from "anon";

revoke delete on table "public"."events" from "authenticated";

revoke insert on table "public"."events" from "authenticated";

revoke references on table "public"."events" from "authenticated";

revoke select on table "public"."events" from "authenticated";

revoke trigger on table "public"."events" from "authenticated";

revoke truncate on table "public"."events" from "authenticated";

revoke update on table "public"."events" from "authenticated";

revoke delete on table "public"."events" from "service_role";

revoke insert on table "public"."events" from "service_role";

revoke references on table "public"."events" from "service_role";

revoke select on table "public"."events" from "service_role";

revoke trigger on table "public"."events" from "service_role";

revoke truncate on table "public"."events" from "service_role";

revoke update on table "public"."events" from "service_role";

revoke delete on table "public"."news_comments" from "anon";

revoke insert on table "public"."news_comments" from "anon";

revoke references on table "public"."news_comments" from "anon";

revoke select on table "public"."news_comments" from "anon";

revoke trigger on table "public"."news_comments" from "anon";

revoke truncate on table "public"."news_comments" from "anon";

revoke update on table "public"."news_comments" from "anon";

revoke delete on table "public"."news_comments" from "authenticated";

revoke insert on table "public"."news_comments" from "authenticated";

revoke references on table "public"."news_comments" from "authenticated";

revoke select on table "public"."news_comments" from "authenticated";

revoke trigger on table "public"."news_comments" from "authenticated";

revoke truncate on table "public"."news_comments" from "authenticated";

revoke update on table "public"."news_comments" from "authenticated";

revoke delete on table "public"."news_comments" from "service_role";

revoke insert on table "public"."news_comments" from "service_role";

revoke references on table "public"."news_comments" from "service_role";

revoke select on table "public"."news_comments" from "service_role";

revoke trigger on table "public"."news_comments" from "service_role";

revoke truncate on table "public"."news_comments" from "service_role";

revoke update on table "public"."news_comments" from "service_role";

revoke delete on table "public"."news_comments_likes" from "anon";

revoke insert on table "public"."news_comments_likes" from "anon";

revoke references on table "public"."news_comments_likes" from "anon";

revoke select on table "public"."news_comments_likes" from "anon";

revoke trigger on table "public"."news_comments_likes" from "anon";

revoke truncate on table "public"."news_comments_likes" from "anon";

revoke update on table "public"."news_comments_likes" from "anon";

revoke delete on table "public"."news_comments_likes" from "authenticated";

revoke insert on table "public"."news_comments_likes" from "authenticated";

revoke references on table "public"."news_comments_likes" from "authenticated";

revoke select on table "public"."news_comments_likes" from "authenticated";

revoke trigger on table "public"."news_comments_likes" from "authenticated";

revoke truncate on table "public"."news_comments_likes" from "authenticated";

revoke update on table "public"."news_comments_likes" from "authenticated";

revoke delete on table "public"."news_comments_likes" from "service_role";

revoke insert on table "public"."news_comments_likes" from "service_role";

revoke references on table "public"."news_comments_likes" from "service_role";

revoke select on table "public"."news_comments_likes" from "service_role";

revoke trigger on table "public"."news_comments_likes" from "service_role";

revoke truncate on table "public"."news_comments_likes" from "service_role";

revoke update on table "public"."news_comments_likes" from "service_role";

alter table "public"."news_comments" drop constraint "news_comments_created_by_fkey";

alter table "public"."news_comments" drop constraint "news_comments_new_id_fkey";

alter table "public"."news_comments_likes" drop constraint "news_comments_likes_comment_fkey";

alter table "public"."news_comments_likes" drop constraint "news_comments_likes_user_fkey";

alter table "public"."events" drop constraint "events_pkey";

alter table "public"."news_comments" drop constraint "news_comments_pkey";

alter table "public"."news_comments_likes" drop constraint "news_comments_likes_pkey";

drop index if exists "public"."events_pkey";

drop index if exists "public"."news_comments_likes_pkey";

drop index if exists "public"."news_comments_pkey";

drop table "public"."events";

drop table "public"."news_comments";

drop table "public"."news_comments_likes";

alter table "public"."news" drop column "images";

alter table "public"."news" drop column "views";