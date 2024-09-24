# zdocs

a simple document storage utility in elixir and phoenix (with ecto/postgres as back end)

how close to a jhipster rest api server can you get with elixir/phoenix very quickly?

app, admin forms for user and document, rest api for user and document, data model for user and document
need a relation between user and document, user has many documents, document belongs to user

mix phx.new zdocs
mix ecto.create

mix phx.server

mix phx.gen.context Admin User users name:string email:string:unique role:string address:string
mix phx.gen.json Admin User users name:string email:string:unique role:string address:string --no-context --no-schema
mix phx.gen.html Admin User users name:string email:string:unique role:string address:string --no-context --no-schema

mix phx.gen.context Publications Document docs title:string description:string public:boolean locator:string source:string
mix phx.gen.json Publications Document docs title:string description:string public:boolean locator:string source:string --no-context --no-schema
mix phx.gen.html Publications Document docs title:string description:text public:boolean locator:string source:string --no-context --no-schema

Some notes on the generated code:

    $ cd zdocs

Then configure your database in config/dev.exs and run:

    $ mix ecto.create

Start your Phoenix app with:

    $ mix phx.server

To migrate changes
    
    $ mix ecto.migrate

You can also run your app inside IEx (Interactive Elixir) as:

    $ iex -S mix phx.server