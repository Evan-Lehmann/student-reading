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
alias App.Quiz.{Mcq, McqAnswer}

non_homophones = ["a", "after", "all", "am", "an", "and", "are", "as", "at", "away", "back", "be", "because", "been", "before", "big", "but", "by", "came", "can", "come", "could", "day", "did", "do", "for", "from", "get", "go", "got", "had", "has", "have", "he", "her", "here", "him", "his", "how", "if", "in", "into", "is", "it", "just", "like", "little", "look", "make", "man", "me", "mother", "my", "no", "not", "now", "of", "on", "one", "or", "our", "out", "over", "play", "put", "said", "saw", "see", "she", "so", "that", "the", "them", "they", "this", "up", "us", "very", "was", "we", "went", "were", "what", "when", "where", "who", "will", "with", "you", "your"]

Enum.each(non_homophones, fn x -> %Mcq{word: x,audio: "/audio/#{x}.mp3", difficulty: "easy"} |> Repo.insert!() && %McqAnswer{word: x} |> Repo.insert!() end)

%Mcq{
  word: "don't",
  audio: "/audio/dont.mp3",
  difficulty: "easy",
}
|> Repo.insert!()

%McqAnswer{
  word: "don't"
}
|> Repo.insert!()

%Mcq{
  word: "I'm",
  audio: "/audio/im.mp3",
  difficulty: "easy",
}
|> Repo.insert!()

%McqAnswer{
  word: "I'm"
}
|> Repo.insert!()


%Mcq{
  word: "I",
  audio: "/audio/i.mp3",
  difficulty: "easy",
}
|> Repo.insert!()

%McqAnswer{
  word: "I"
}
|> Repo.insert!()

%Mcq{
  word: "their",
  audio: "/audio/their.mp3",
  difficulty: "easy",
  hint: "their"
}
|> Repo.insert!()

%McqAnswer{
  word: "their",
  hint: "their"
}
|> Repo.insert!()


%Mcq{
  word: "there",
  audio: "/audio/there.mp3",
  difficulty: "easy",
  hint: "their"
}
|> Repo.insert!()

%McqAnswer{
  word: "there",
  hint: "their"
}
|> Repo.insert!()


%Mcq{
  word: "than",
  audio: "/audio/than.mp3",
  difficulty: "easy",
  hint: "than"
}
|> Repo.insert!()

%McqAnswer{
  word: "than",
  hint: "than"
}
|> Repo.insert!()


%Mcq{
  word: "then",
  audio: "/audio/then.mp3",
  difficulty: "easy",
  hint: "than"
}
|> Repo.insert!()

%McqAnswer{
  word: "then",
  hint: "than"
}
|> Repo.insert!()


%Mcq{
  word: "to",
  audio: "/audio/to.mp3",
  difficulty: "easy",
  hint: "to"
}
|> Repo.insert!()

%McqAnswer{
  word: "to",
  hint: "to"
}
|> Repo.insert!()


%Mcq{
  word: "too",
  audio: "/audio/too.mp3",
  difficulty: "easy",
  hint: "to"
}
|> Repo.insert!()

%McqAnswer{
  word: "too",
  hint: "to"
}
|> Repo.insert!()

%Mcq{
  word: "two",
  audio: "/audio/two.mp3",
  difficulty: "easy",
  hint: "to"
}
|> Repo.insert!()

%McqAnswer{
  word: "two",
  hint: "to"
}
|> Repo.insert!()
