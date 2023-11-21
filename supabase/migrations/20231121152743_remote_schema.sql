CREATE TRIGGER on_signup_insert_profile AFTER INSERT ON auth.users FOR EACH ROW EXECUTE FUNCTION create_new_user_profile();


