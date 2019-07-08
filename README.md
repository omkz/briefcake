# SJABLOON README

Thanks for using Sjabloon to get a flying start with your new Ruby on Rails project! 🎊

## Quickstart guide
There are a few steps you have to do manually. See below this quickstart for more in depth information on various features of Sjabloon.

1. You can run your new Rails app using `foreman start` or `foreman s`.
2. You app can be found at `http://localhost:5000` (💡 cmd + click)
3. Easily copy/paste UI components from the library at https://www.getsjabloon.com/features/ui-components#components
4. Work on your core product right away ✨

For details about billing with Stripe, please check the additional README_FOR_BILLING.

### Rails Credentials
Sjabloon uses Rails credentials (it's how your Sentry and Mailgun integration is set up). If your new to Rails credentials, you can read this: https://medium.com/cedarcode/rails-5-2-credentials-9b3324851336
You can access these using `EDITOR="vim -f" rails credentials:edit`, where you can replace `vim` with your editor of choice. You can use this template:
```yml
secret_key_base: …
default: &default

development:
  <<: *default
  stripe:
    private_key: ''
    public_key: ''
    signing_secret: ''
  

production:
  <<: *default
  stripe:
    private_key: ''
    public_key: ''
    signing_secret: ''
  
  mailgun:
    smtp_login: ''
    smtp_password: ''
  
  
  
  
  sentry:
    dsn: ''
  
  
  
  
  
  tawkto:
    id: ''
```

#### Sentry
If you don't have a Sentry account, go here: [https://sentry.com](https://sentry.com)

#### Mailgun
If you don't have a Mailgun account, go here: [https://mailgun.com](https://mailgun.com)

## Running your app in development
You can run your new application with `foreman start` or shorthand `foreman s` (it uses Procfile.dev as set in the `.foreman` file). Foreman also reads the contents from the `.env` file, which you can use for any environment variables.

## Modern front end
Sjabloon utilises a lean, but modern front end. Webpack as the Javascript bundler (bundled by default with Rails 5+), PostCss to add some magic to your Css, Tailwind as the utility-first CSS framework and Stimulus as the JS framework. These tools are proven to make sure you make powerful web applications, without overly complicating stuff. All powerful enough to get that important first version out of the door.

### [Webpack](https://webpack.js.org)
Webpack comes by default with every new Rails (5+) application using the [Webpacker gem](https://github.com/rails/webpacker). In development it's run as `./bin/webpack --watch --colors --progress` with [Foreman](https://github.com/ddollar/foreman).

### [PostCss](https://https://postcss.org)
Also PostCss comes as default with Rails 5+. It's a tool to transform your CSS with Javascript. As such it can do everything Scss/Sass does, and a lot more. A lot! It works by adding small plugins that do one thing well. Sjabloon comes with the following plugins installed for you:

- [postcss-import](https://github.com/postcss/postcss-import). See how this is used in `frontend/stylesheets/application.css`
- [postcss-preset-env](https://github.com/csstools/postcss-preset-env) A set of plugins to convert modern CSS into something browsers understand today.
- [postcss-nested](https://github.com/postcss/postcss-nested) This unwraps nested styles similar to Scss/Sass.

### [Tailwind](https://tailwindcss.com)
Tailwind is a utility-first Css framework. It solely consist of one-off classes, like `.mb-4`, `.text-white` and `.text-base`. This lets you create UI's really quick as you only have to add some classes to build a component. And once you reuse a component, you can extract the class into its own Css selector with `@apply`. And then one of the Css files in `frontend/stylesheets/components`. [See here for some components examples](https://www.getsjabloon.com/features/ui-components). Note: you need to uncomment some files/imports in `frontend/stylesheets/components.css` to use these specfic components.

### [Stimulus](https://stimulusjs.org)
Stimulus is a nice and modest framework that allows you to add just enough JS to make your UI shine. No crazy new templating, but the HTML you already use.

Since this front end is not reliant on Sprockets (although you opted to include it in this template), all front end related code is in `/frontend` instead of `app/assets`. So, if you really need to include another JS framework, like React or Vue, this folder is the perfect place for it too. _Your `ERB` views can still be found in `/app/views` though._

## Act as Person
You can see and use your app as another user with the installed `devise_masquerade` gem. It only works if you are logged in and have `admin` on your record set to true.
Next you can go to http://localhost:3000/masquerade/{user_id}—where `user_id` is the user of choice. When logged in as a different user, you'll see a small banner at the bottom to notify you about this and a button to go back as your original user record.

## Announcements
Announcements about your new product are a great way for your customers and Users to show you are actively working on the product. Announcements with Sjabloon can be used as a changelog and announcements can be shown throughout your app. In the latter case, a banner is shown at the top of every page. The user can click-through to go to the /announcements page or they dismiss the banner (which will set a cookie to store this info).
You can create new announcements easily like this (make sure there's at least one User):
```rb
Announcement.create!(
title: 'The title of the announcement',
body: 'Some body copy. This shown on /announcements',
user_id: 1,
show_site_wide: ['users' || 'visitors'], # optional
announcement_type: ['new' || 'bugfix' || 'update'], # defaults to 'new'
target: '' # optional, link to a different page
published_at: <Time.zone.now> # optional, defaults to Time.zone.now
)
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
