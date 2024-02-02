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
alias App.Quiz.{Word, Level, Mcq, McqAnswer}

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
  rarity: "rare"
}
|> Repo.insert!()

## Multiple Choice Questions
%Mcq{
  id: 1,
  content: "When Melissa saw the dark _____ in the sky, she knew it was going to rain.",
  image: "/images/mcq-id-1.png"
}
|> Repo.insert!()

          %McqAnswer{
            mcq_id: 1,
            content: "birds",
            is_correct: false
          }
          |> Repo.insert!()

          %McqAnswer{
            mcq_id: 1,
            content: "trees",
            is_correct: false
          }
          |> Repo.insert!()

          %McqAnswer{
            mcq_id: 1,
            content: "umbrellas",
            is_correct: false
          }
          |> Repo.insert!()

          %McqAnswer{
            mcq_id: 1,
            content: "clouds",
            is_correct: true
          }
          |> Repo.insert!()

%Mcq{
  id: 2,
  content: "Aramando ______ to be a writer so that people can enjoy his stories.",
  image: "/images/mcq-id-2.png"
}
|> Repo.insert!()

          %McqAnswer{
            mcq_id: 2,
            content: "find",
            is_correct: false
          }
          |> Repo.insert!()

          %McqAnswer{
            mcq_id: 2,
            content: "wants",
            is_correct: true
          }
          |> Repo.insert!()

          %McqAnswer{
            mcq_id: 2,
            content: "listens",
            is_correct: false
          }
          |> Repo.insert!()

          %McqAnswer{
            mcq_id: 2,
            content: "helps",
            is_correct: false
          }
          |> Repo.insert!()

%Mcq{
  id: 3,
  content: "The Gonzales family sits down at the table. They eat dinner ______.",
  image: "/images/mcq-id-3.png"
}
|> Repo.insert!()

          %McqAnswer{
            mcq_id: 3,
            content: "together",
            is_correct: true
          }
          |> Repo.insert!()

          %McqAnswer{
            mcq_id: 3,
            content: "group",
            is_correct: false
          }
          |> Repo.insert!()

          %McqAnswer{
            mcq_id: 3,
            content: "tomorrow",
            is_correct: false
          }
          |> Repo.insert!()

          %McqAnswer{
            mcq_id: 3,
            content: "instead",
            is_correct: false
          }
          |> Repo.insert!()

%Mcq{
  id: 4,
  content: "A lot of snow fell last night. Joslyn put on her tall boots to walk in the ______ snow.",
  image: "/images/mcq-id-4.png"
}
|> Repo.insert!()

          %McqAnswer{
            mcq_id: 4,
            content: "fair",
            is_correct: false
          }
          |> Repo.insert!()

          %McqAnswer{
            mcq_id: 4,
            content: "deep",
            is_correct: true
          }
          |> Repo.insert!()

          %McqAnswer{
            mcq_id: 4,
            content: "true",
            is_correct: false
          }
          |> Repo.insert!()

          %McqAnswer{
            mcq_id: 4,
            content: "dirty",
            is_correct: false
          }
          |> Repo.insert!()

%Word{
  id: 1,
  content: "a",
  sound: "/audio/a.mp3"
}
|> Repo.insert!()

%Word{
  id: 2,
  content: "after",
  sound: "/after/a.mp3"
}
|> Repo.insert!()

%Word{
  id: 3,
  content: "all",
  sound: "/all/a.mp3"
}
|> Repo.insert!()

%Level{
  id: 1,
  number: 1,
}
|> Repo.insert!()

%Level{
  id: 2,
  number: 2,
}
|> Repo.insert!()

%Level{
  id: 3,
  number: 3,
}
|> Repo.insert!()
