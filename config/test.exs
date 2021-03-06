use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :auction, Auction.Endpoint,
  http: [port: 4001],
  server: true

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :auction, Auction.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "auction_test",
  hostname: "localhost",
  port: "5433",
  pool: Ecto.Adapters.SQL.Sandbox

config :hound, driver: "chrome_driver"
config :auction, sql_sandbox: true