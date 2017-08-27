use Mix.Config

config :data,
  ecto_repos: [Data.Repo],
  levels: [1, 5, 9],
  level_label_mapping: %{
    1 => ["kind:beginner", "kind:starter", "level:starter"],
    5 => ["kind:intermediate", "level:intermediate"],
    9 => ["kind:advanced", "level:advanced"]
  },
  types: ["type-bug", "type-documentation", "type-enhancement", "type-feature"],
  type_label_mapping: %{
    "type-bug" => ["kind:bug", "bug"],
    "type-documentation" => ["kind:documentation", "documentation"],
    "type-enhancement" => ["kind:enhancement", "enhancement"],
    "type-feature" => ["kind:feature", "feature"]
  }

config :data, Data.Repo,
  loggers: [Appsignal.Ecto, Ecto.LogEntry]

import_config "#{Mix.env}.exs"
