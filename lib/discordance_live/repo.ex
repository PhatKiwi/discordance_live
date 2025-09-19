defmodule DiscordanceLive.Repo do
  use Ecto.Repo,
    otp_app: :discordance_live,
    adapter: Ecto.Adapters.Postgres
end
