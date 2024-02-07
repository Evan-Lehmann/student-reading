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


%Mcq{
  word: "a",
  audio: "/audio/a.mp3",
  difficulty: "easy"
}
|> Repo.insert!()

%Mcq{
  word: "after",
  audio: "/audio/after.mp3",
  difficulty: "easy"
}
|> Repo.insert!()


%Mcq{
  word: "all",
  audio: "/audio/all.mp3",
  difficulty: "easy"
}
|> Repo.insert!()

%Mcq{
  word: "am",
  audio: "/audio/am.mp3",
  difficulty: "easy"
}
|> Repo.insert!()

%Mcq{
  word: "an",
  audio: "/audio/an.mp3",
  difficulty: "easy"
}
|> Repo.insert!()

%Mcq{
  word: "and",
  audio: "/audio/and.mp3",
  difficulty: "easy"
}
|> Repo.insert!()

%Mcq{
  word: "are",
  audio: "/audio/are.mp3",
  difficulty: "easy"
}
|> Repo.insert!()

%Mcq{
  word: "as",
  audio: "/audio/as.mp3",
  difficulty: "easy"
}
|> Repo.insert!()

%Mcq{
  word: "at",
  audio: "/audio/at.mp3",
  difficulty: "easy"
}
|> Repo.insert!()

%Mcq{
  word: "away",
  audio: "/audio/away.mp3",
  difficulty: "easy"
}
|> Repo.insert!()

%Mcq{
  word: "back",
  audio: "/audio/back.mp3",
  difficulty: "easy"
}
|> Repo.insert!()

%Mcq{
  word: "be",
  audio: "/audio/be.mp3",
  difficulty: "easy"
}
|> Repo.insert!()

%Mcq{
  word: "because",
  audio: "/audio/because.mp3",
  difficulty: "easy"
}
|> Repo.insert!()

%Mcq{
  word: "been",
  audio: "/audio/been.mp3",
  difficulty: "easy"
}
|> Repo.insert!()

%Mcq{
  word: "before",
  audio: "/audio/before.mp3",
  difficulty: "easy"
}
|> Repo.insert!()

%Mcq{
  word: "big",
  audio: "/audio/big.mp3",
  difficulty: "easy"
}
|> Repo.insert!()

%Mcq{
  word: "but",
  audio: "/audio/but.mp3",
  difficulty: "easy"
}
|> Repo.insert!()

%Mcq{
  word: "by",
  audio: "/audio/by.mp3",
  difficulty: "easy"
}
|> Repo.insert!()

%McqAnswer{
  word: "a"
}
|> Repo.insert!()

%McqAnswer{
  word: "after"
}
|> Repo.insert!()

%McqAnswer{
  word: "all"
}
|> Repo.insert!()

%McqAnswer{
  word: "am"
}
|> Repo.insert!()

%McqAnswer{
  word: "an"
}
|> Repo.insert!()

%McqAnswer{
  word: "and"
}
|> Repo.insert!()

%McqAnswer{
  word: "are"
}
|> Repo.insert!()

%McqAnswer{
  word: "as"
}
|> Repo.insert!()

%McqAnswer{
  word: "at"
}
|> Repo.insert!()

%McqAnswer{
  word: "away"
}
|> Repo.insert!()

%McqAnswer{
  word: "back"
}
|> Repo.insert!()

%McqAnswer{
  word: "be"
}
|> Repo.insert!()

%McqAnswer{
  word: "because"
}
|> Repo.insert!()

%McqAnswer{
  word: "been"
}
|> Repo.insert!()

%McqAnswer{
  word: "before"
}
|> Repo.insert!()

%McqAnswer{
  word: "big"
}
|> Repo.insert!()

%McqAnswer{
  word: "but"
}
|> Repo.insert!()

%McqAnswer{
  word: "by"
}
|> Repo.insert!()
