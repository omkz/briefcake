## Quickstart guide
There are a few steps you have to do manually. See below this quickstart for more in depth information on various features of Sjabloon.

1. You can run your new Rails app using `foreman start` or `foreman s` or `bin/dev`.
2. You app can be found at `http://localhost:5000` (💡 cmd + click)
3. Easily copy/paste UI components from the library at https://www.getsjabloon.com/features/ui-components#components
4. Work on your core product right away ✨

For details about billing with Stripe, please check the additional README_FOR_BILLING.


## Testing

### On production

```
heroku run rails c -a briefcake
UserMailer.test_email('lunaticman@gmail.com')
```



## Transactional emails
“Transactional emails” are emails such as email confirmation, password reset link, etc.
In **development**, [letter_opener](https://github.com/ryanb/letter_opener) is included. It's an easy way to preview in real-time (instead of the default log output). Check `config/environments/development.rb` how this is set up.
You can also go to [http://localhost:5000/rails/mailers](http://localhost:5000/rails/mailers) to preview the emails in the browser. `reset_password_instructions` is defined here to preview the reset password email from Devise (be sure there is at least one User in the database).
In **production**, you use Mailgun for your transactional emails. Be sure your domainname (eg. https://www.getsjabloon.com) and your naked domain (eg. getsjabloon.com) are correct. Check `config/application.rb` to change these.

## Production specific settings (eg. config/environments/production.rb)

- SSL is forced; good practice for your Users and search engines won't penalise for being unsafe
- adding `Rack::Deflater`; the the simplest thing to drastically reduce the size of your HTML / JSON controller responses

### Email design
All styles for the emails can be found in `frontend/stylesheets/emails.css`. These styles are automatically inlined using the [Premailer gem](https://github.com/premailer/premailer) ensuring emails look good in multiple email clients. It also creates a text variant of every email for you.

### FriendlyID
[FriendlyID](https://github.com/norman/friendly_id/) is the "Swiss Army bulldozer" of slugging and permalink plugins for Active Record. It basically allows you to have “pretty” links instead of rails default id's.
In your model (where `name` is a column in your `companies` table—don't forget to add a `slug` “string” column too):
```rb
class Company < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
end
```
In your controller:
```rb
def set_company
  @company = Company.friendly.find(params[:id])
end
```

Sjabloon also adds a `Friendlyable` (app/models/concerns/friendlyable.rb) concern for you. All it needs is a `hash_id` column in the model's database and include it on the model. Having a separate hash_id instead of the default id is good for security reasons.
```rb
class Download < ApplicationRecord
  include Friendlyable
end
```


## Miscellaneous

## Deploying your app
To have a smooth deploy, be sure to add the contents of `config/master.key` to your environment variables as `RAILS_MASTER_KEY`. It's really important to never share this `RAILS_MASTER_KEY` in any shared repository or public space! By default it's excluded from Git, through the `.gitignore` file.

Don't know where to deploy your app? I can highly recommend the combo [DigitalOcean](https://m.do.co/c/5ca1e8d17563) and [Hatchbox](https://hatchbox.io/?via=sjabloon). Other hosting services (that can be used with Hatchbox) are: Linode and Vultr. Another solid choice is still [Heroku](https://www.heroku.com)
