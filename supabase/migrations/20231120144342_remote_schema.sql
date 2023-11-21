create policy "default mt58pq_0"
on "storage"."objects"
as permissive
for select
to public
using ((bucket_id = 'services'::text));


create policy "default mt58pq_1"
on "storage"."objects"
as permissive
for insert
to public
with check ((bucket_id = 'services'::text));


create policy "default mt58pq_2"
on "storage"."objects"
as permissive
for update
to public
using ((bucket_id = 'services'::text));


create policy "default mt58pq_3"
on "storage"."objects"
as permissive
for delete
to public
using ((bucket_id = 'services'::text));


create policy "normal 1oj01fe_0"
on "storage"."objects"
as permissive
for select
to public
using ((bucket_id = 'avatars'::text));


create policy "normal 1oj01fe_1"
on "storage"."objects"
as permissive
for insert
to public
with check ((bucket_id = 'avatars'::text));


create policy "normal 1oj01fe_2"
on "storage"."objects"
as permissive
for delete
to public
using ((bucket_id = 'avatars'::text));


create policy "normal 1oj01fe_3"
on "storage"."objects"
as permissive
for update
to public
using ((bucket_id = 'avatars'::text));


create policy "normal 20edv_0"
on "storage"."objects"
as permissive
for select
to public
using ((bucket_id = 'news'::text));


create policy "normal 20edv_1"
on "storage"."objects"
as permissive
for insert
to public
with check ((bucket_id = 'news'::text));


create policy "normal 20edv_2"
on "storage"."objects"
as permissive
for update
to public
using ((bucket_id = 'news'::text));


create policy "normal 20edv_3"
on "storage"."objects"
as permissive
for delete
to public
using ((bucket_id = 'news'::text));



