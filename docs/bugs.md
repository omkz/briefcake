Migration error: Migrating with `acts_as_paranoid` in the `user.rb` model definition causes a migration error.
This happens when migrating from a blank slate because the earlier migrations try to load the user model and the acts as paranoid gem expects a column to be there that isn't. 
One solution is to remove that line from the user definition, run the migrations, then put it back in.