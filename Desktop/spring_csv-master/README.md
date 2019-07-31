# README

# SpringBig Rails CSV App
---

# 
 * [Directions](#part-500)
 * [System Requirements](#part-750)
 * [Database](#part-1000)
 * [Documentation Links](#part-1100)
 * [Initial Steps](#part-1600)
 * [Testing with Rspec](#part-2600)
 * [CSV- Upload and Display](#part-3600)
 * [Deploy to Production](#4600)
 ---

## Guide <a id="part-500"></a>

* Install System Requirements
* Install Gems `bundle install`
* Run PostgreSQL
* Run Rails Server `rails s`
* Go to http://localhost:3000
* Click "Choose File" (to upload a CSV)
* Select the [contacts.csv]() file located in the root directory
* Click "Import CSV"
* Click the "1", "2", "Next" or "Previous" to change Page using Pagination
* Click the column Labels (i.e. "Uid", "Phone", "First", "Last", "Email") to filter ordering ascending/descending
* The Uid ^ column name serves as the identifier as instructed in the SpringBig Test app I was sent
* Enter a value in the input field (case sensitive). Click "Search" to filter list.


## System Requirements for Application <a id="part-750"></a>
* Show System Setup
   `rails about`

* Versions used:
   * Rails - 5.0.0', '>= 5.0.0.1'
   * Ruby - 2.4.0-p0 (see .ruby-version)
   * RubyGems - 3.0.4
   * Ruby Gemset - springbig_csv_app (see .ruby-gemset)
   * Rack - 2.0.1
   * JavaScript Runtime Node.js (V8)
   * PostgreSQL - 11.4
   * RSpec - 3.5.4
   * OS - macOS Mojave



## Database <a id="part-1000"></a>

* Make sure to have Homebrew installed
* Follow steps found here , just make sure to adjust your Ruby on Rails versions:
   `http://railsapps.github.io/installrubyonrails-mac.html`

* Run PostgreSQL without background service:
    `pg_ctl -D /usr/local/var/postgres start`
* Configure to start PostgreSQL and restart at login using launchd background service:
    `brew services start postgresql`
* Open PostgreSQL Database console automatically http://guides.rubyonrails.org/command_line.html
   `rails dbconsole`
* Make sure to stop PostgreSQL from running as soon as your done running app in dev env to avoid potential issues
   `pg_ctl -D /usr/local/var/postgres stop`

* Show database table contents
   ```
   select * from contacts;
   ```

## Documentation Links <a id="part-1600"></a>

* Testing
   * RSpec Rails https://github.com/rspec/rspec-rails

## Initial Steps <a id="part-2000"></a>

* Create Project
    ```
    rails new springbig_csv_app --database=postgresql
    rvm list
    ```

* Install latest RVM to install and use latest Ruby version. Update PostgreSQL.
    ```
    rvm get master
    rvm install ruby-2.4.0
    brew upgrade bash
    brew update
    brew reinstall postgresql
    rvm reinstall ruby-2.4.0
    rvm use ruby-2.4.0
    ```

* Update to latest RubyGems version https://rubygems.org/pages/download
   ```
   gem install rubygems-update
   update_rubygems
   gem update --system
   ```

* Update to latest JavaScript Runtime. Install NVM.
 Check latest stable Node.js version https://nodejs.org
 Check current version and update.
 Install latest version of NPM.
   ```
   node -v
   npm install -g npm
   nvm install 7.7.1
   nvm use 7.7.1
   ```

* Create custom Gemset with RVM
    ```
    rvm gemset create springbig_csv_master
    rvm --ruby-version use 2.4.0@springbig_csv_master
    ```

* Check latest Rails version that is available: https://rubygems.org/gems/rails/versions
* Install latest specific Rails version
    `gem install rails --version 5.0.2`

* Check database.yml is setup correctly for development , instructions are here

 `https://devcenter.heroku.com/articles/getting-started-with-rails5`

* Check that using custom GemSet. Install default Gems in Gemfile
   ```
   rvm --ruby-version use 2.4.0@springbig_csv_master
   gem install bundler
    bundle install
    ```

* Migrate into PostgreSQL Database
    ```
    rake db:create db:migrate RAILS_ENV=development
    ```

* Launch the Rails server in separate Terminal tab automatically and opens it in web browser after 10 seconds using Shell Script:
   `bash launch.sh`

   * Alternatively: Run server command, and then manually go to url, or in a separate tab run command to open app in browser
       `rails s`
       `open http://localhost:3000`


## Testing with RSpec <a id="part-3000"></a>

* Remove Test Unit's directory and files
   `rm -rf test/`

* Add RSpec to test group within Gemfile to retrieve latest patch https://github.com/rspec/rspec-rails
   `gem 'rspec-rails', '~> 3.5.2'`

* Initialise /spec directory
   `rails generate rspec:install`

* Run RSpec tests
   `rspec`
### Fake CSV Generator <a id="part-9000"></a>

* Faked CSV Gem https://github.com/jiananlu/faked_csv
   * Create file `fake_csv_config.csv.json`
   * Configure it to output CSV data in format desired and supports Faker Gem https://github.com/stympy/faker
   * Execute it with the following to generate random CSV:
       `faked_csv -i fake_csv_config.csv.json -o products.csv`
   * Insert the Labels at the top of the generated file, i.e.
       `uid,phone,first,last,email`
  

## CSV Upload and Display <a id="part-4000"></a>
* Generate Model

   ```
   rails g model Contact uid:string phone:string first:string last:string email:string

   ```

* Modify the migration file as follows:
    `t.string :uid, t.string :phone, t.string :first, t.string :last, t.string :email`

* Migrate
   `rake db:migrate RAILS_ENV=development`


* Generate Controller with index and import Actions
   `rails g controller Contacts index import`

* Modify Routes as follows:
    ```
    resources :contacts do
 	 collection { post :import }
    end

    root to: "contacts#index"
    ```

* Create a CSV file called contacts.csv

* Run server and upload the CSV file, then check it exists in database. Drop database and re-migrate to further test
    ```
    rails dbconsole
    select * from contacts;
    rake db:drop
    rake db:create db:migrate RAILS_ENV=development
    ```

* Add Unit Tests by adding the following gem to allow use of `assigns` in Controller tests
    `gem 'rails-controller-testing', '~> 1.0.1'`


## Deploy to Production : Heroku <a id="part-4600"></a>       

* Since we're using rails 5 , we do not need to install gem 'rails_12factor', however, please that you have this within your
 config/environments/production.rb file
``` 
config/environments/production.rb
config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?
if ENV["RAILS_LOG_TO_STDOUT"].present?
 logger           = ActiveSupport::Logger.new(STDOUT)
 logger.formatter = config.log_formatter
 config.logger = ActiveSupport::TaggedLogging.new(logger)
end

```

* All instructions to push app to production environment can be found here:

`https://devcenter.heroku.com/articles/getting-started-with-rails5#local-setup`



