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
alias App.Quiz.{Story, Question, Answer}

%Avatar{
  id: 1,
  image: "/images/astronaut.png",
  rarity: "common"
}
|> Repo.insert!()

%Avatar{
  id: 2,
  image: "/images/alien.png",
  rarity: "common"
}
|> Repo.insert!()

%Avatar{
  id: 3,
  image: "/images/astrodog.png",
  rarity: "uncommon"
}
|> Repo.insert!()

%Avatar{
  id: 4,
  image: "/images/asteroid.png",
  rarity: "epic"
}
|> Repo.insert!()

%Story{
  id: 1,
  content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. "
}
|> Repo.insert!()

%Question{
  id: 1,
  story_id: 1,
  content: "What language is the excerpt written in?"
}
|> Repo.insert!()

%Answer{
  question_id: 1,
  content: "Latin",
  is_correct: true
}
|> Repo.insert!()

%Answer{
  question_id: 1,
  content: "French",
  is_correct: false
}
|> Repo.insert!()

%Answer{
  question_id: 1,
  content: "Italian",
  is_correct: false
}
|> Repo.insert!()

%Question{
  id: 2,
  story_id: 1,
  content: "When is the excerpt thought to have originated?"
}
|> Repo.insert!()

%Answer{
  question_id: 2,
  content: "5th century CE",
  is_correct: false
}
|> Repo.insert!()

%Answer{
  question_id: 2,
  content: "1st century BC",
  is_correct: true
}
|> Repo.insert!()

%Answer{
  question_id: 2,
  content: "2nd century CE",
  is_correct: false
}
|> Repo.insert!()

%Question{
  id: 3,
  story_id: 1,
  content: "Who is thought to be the author?"
}
|> Repo.insert!()

%Answer{
  question_id: 3,
  content: "Socrates",
  is_correct: false
}
|> Repo.insert!()

%Answer{
  question_id: 3,
  content: "Diogenes",
  is_correct: false
}
|> Repo.insert!()

%Answer{
  question_id: 3,
  content: "Cicero",
  is_correct: true
}
|> Repo.insert!()
