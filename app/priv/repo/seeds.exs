# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     App.Repo.insert!(%App.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias App.Repo
alias App.Avatars.Avatar

%Avatar{
  id: 1,
  image: "/images/astronaut.png",
}
|> Repo.insert!()

%Avatar{
  id: 2,
  image: "/images/alien.png",
}
|> Repo.insert!()
